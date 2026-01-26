#!/bin/bash


# validate an RDF+XML against the DCAT-AP.PLU SHACL schema using the EU REST API
validate_example() {
    shacl=$(base64 -w 0 $(dirname "$0")/shacl/dcat-ap-plu_shacl-shapes.ttl)
    example=$(base64 -w 0 "$1")
    json=$(curl -s --location 'https://www.itb.ec.europa.eu/shacl/shacl/api/validate' \
    --header 'Content-Type: application/json' \
    --data '{
        "contentToValidate": "'${example}'",
        "contentSyntax": "application/rdf+xml",
        "embeddingMethod": "BASE64",
        "validationType": "core",
        "externalRules": [{
            "ruleSet": "'${shacl}'",
            "embeddingMethod": "BASE64",
            "ruleSyntax": "text/turtle"
        }],
        "reportSyntax": "application/json"
    }')
    if [[ "$json" =~ '"result"'[[:space:]]*':'[[:space:]]*'"SUCCESS"' ]]; then
        return 0
    else
        return 1
    fi
}


# make sure we're on develop
echo -n "Checking if on branch \"develop\"... "
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" == "develop" ]; then
    echo "ok"
else
    echo -e "fail\n"
    echo "TODO: Manually checkout \"develop\"."
    echo "Aborting release"
    exit 1
fi

# check if the working tree is clean
echo -n "Checking working tree... "
if [ -z "$(git status --porcelain)" ]; then
    echo "clean"
else
    echo "dirty"
    echo "TODO: Manually commit/stash/clean changes."
    echo "Aborting release"
    exit 1
fi

# check if ado remote is configured
echo -n "Checking if ado connection is configured... "
if git ls-remote --exit-code ado > /dev/null 2>&1; then
    echo "ok"
else
    echo -e "fail\n"
    echo "TODO: Add git remote \"ado\" pointing to the Azure DevOps repository."
    echo "Aborting release"
    exit 1
fi

# check if a merge will be conflict-free
echo -n "Checking if merge with main is conflict-free... "
git fetch ado main > /dev/null 2>&1
if git merge-tree --write-tree ado/main develop > /dev/null 2>&1; then
    echo "ok"
else
    echo -e "fail\n"
    echo "TODO: Manually merge ado/main into develop."
    echo "Aborting release"
    exit 1
fi

echo -en "\nRunning pre-release tests..."

# validate all PLU examples using the `SHACL` shapefile
echo -e "Validating PLU examples..."
for file in "$(dirname "$0")/examples"/*; do
    filename=$(basename "$file")
    if [[ $filename != plu* ]]; then
        continue
    fi
    echo -n "  validating $file... "
    if validate_example "$file"; then
        echo "ok"
    else
        echo "failed"
        echo -e "Aborting release, error:\n ${json}"
        exit 1
    fi
done

# do not automatically tidy the documentation, but check if it is tidy
echo -n "Validating documentation tidiness... "
diff $(dirname "$0")/doc-plu.html <(tidy -config $(dirname "$0")/scripts/tidy/tidy.config -quiet $(dirname "$0")/doc-plu.html)
if [ $? -eq 0 ]; then
    echo "ok"
else
    echo -e "fail\n"
    echo "TODO: Run tidy (scripts/tidy)."
    echo "Aborting release"
    exit 1
fi

# latest version
LATEST_VERSION=$(git show ado/main:CHANGELOG.md | grep -m 1 -E "^## [0-9]{4}-[0-9]{2}-[0-9]{2} - " | sed 's@.* - @@')
echo -e "\nLatest released version is ${LATEST_VERSION}"

# choose new version type
echo -en "\nWhich version do you want to release [major, minor, patch]? "
read VERSION_TYPE
if [ "${VERSION_TYPE}" != "major" ] && [ "${VERSION_TYPE}" != "minor" ] && [ "${VERSION_TYPE}" != "patch" ]; then
    echo "Version has to be one of [major, minor, patch], aborting..."
    exit 1
fi

# build new version number
DRAFT_VERSION="../drafts/0.0.1-draft-0.1"
ESC_DRAFT_VERSION="\.\./drafts/0\.0\.1-draft-0\.1"
VERSION_ARRAY=( ${LATEST_VERSION//./ } )
ESC_LATEST_VERSION="${VERSION_ARRAY[0]}\.${VERSION_ARRAY[1]}\.${VERSION_ARRAY[2]}"
case ${VERSION_TYPE} in
    "major")
        ((VERSION_ARRAY[0]++))
        VERSION_ARRAY[1]=0
        VERSION_ARRAY[2]=0
        ;;
    "minor")
        ((VERSION_ARRAY[1]++))
        VERSION_ARRAY[2]=0
        ;;
    "patch")
        ((VERSION_ARRAY[2]++))
        ;;
esac
NEXT_VERSION="${VERSION_ARRAY[0]}.${VERSION_ARRAY[1]}.${VERSION_ARRAY[2]}"

echo -en "Preparing to release new ${VERSION_TYPE} version ${NEXT_VERSION}, continue [Y/n]? "
read CONTINUE_RELEASE
if [[ "${CONTINUE_RELEASE}" != "y" && "${CONTINUE_RELEASE}" != "Y" && "${CONTINUE_RELEASE}" != "" ]]; then
    echo "You cancelled the release process, aborting..."
    exit 1
fi

# go to project root
pushd "$(dirname "$0")/../../" > /dev/null || exit 1

# check if changelog format is consistent and set the new version in changelog
if ! grep -Fq "## xxxx-xx-xx - dev" CHANGELOG.md; then
    echo "The changelog must contain the line \"## xxxx-xx-xx - dev\", aborting..."
    exit 1
fi

# prepare release
echo -e "\nUpdating changelog..."
sed -i "s@## xxxx-xx-xx - dev@## $(date --iso-8601) - ${NEXT_VERSION}@g" CHANGELOG.md
# create a new folder in releases, named after the new version number (semver)
mkdir -p releases/${NEXT_VERSION}/examples

# copy all appropriate files from drafts/0.0.1-draft-0.1 into this new folder
echo -e "\nCopying files from drafts/0.0.1-draft-0.1 to releases/${NEXT_VERSION}..."
cp -r drafts/0.0.1-draft-0.1/codelists releases/${NEXT_VERSION}/
cp -r drafts/0.0.1-draft-0.1/examples/plu* releases/${NEXT_VERSION}/examples/
cp -r drafts/0.0.1-draft-0.1/shacl releases/${NEXT_VERSION}/
cp -r drafts/0.0.1-draft-0.1/styles releases/${NEXT_VERSION}/
cp drafts/0.0.1-draft-0.1/api-plu.yml releases/${NEXT_VERSION}/
cp drafts/0.0.1-draft-0.1/DCAT-AP-PLU.JPG releases/${NEXT_VERSION}/
cp drafts/0.0.1-draft-0.1/doc-plu.html releases/${NEXT_VERSION}/
cp releases/${LATEST_VERSION}/README.md releases/${NEXT_VERSION}/

echo -e "Updating version in files..."
# in the new version folder, change `doc-plu.html`
# ... set `latestVersion`
sed -i "s@latestVersion: \".*\",@latestVersion: \"https://github.com/wemove/dcat-ap-plu/tree/main/releases/${NEXT_VERSION}\",@g" releases/${NEXT_VERSION}/doc-plu.html
# ... replace `specStatus` with `publishDate`
sed -i "s@specStatus: \"unofficial\",@publishDate: \"$(date + '%Y-%m-%d')\",@g" releases/${NEXT_VERSION}/doc-plu.html
# ... add "override" to #sotd
sed -i "s@<section id=\"sotd\" class=\"introductory\">@<section id=\"sotd\" class=\"introductory override\">@g" releases/${NEXT_VERSION}/doc-plu.html
# in the new version folder, change the `version` property in `api-plu.yml`
sed -i "s@version: x.y.z@version: ${NEXT_VERSION}@g" releases/${NEXT_VERSION}/api-plu.yml
# in the new version folder, change the version in `README.md`
sed -i "s@DCAT-AP\.PLU v\?${ESC_LATEST_VERSION}@DCAT-AP.PLU ${NEXT_VERSION}@g" releases/${NEXT_VERSION}/README.md
# update the `DCATAPPLU_VERSION` in the Dockerfile
sed -i "s@ENV DCATAPPLU_VERSION=${ESC_DRAFT_VERSION}@ENV DCATAPPLU_VERSION=${NEXT_VERSION}@g" Dockerfile

# commit, merge, tag new release
echo
git add .
git commit -m "Prepare for ${NEXT_VERSION} release"

# merge, tag new release
git checkout main
git merge --no-ff -m "Release ${NEXT_VERSION}" develop
git tag -a ${NEXT_VERSION} -m "Release ${NEXT_VERSION}"

# prepare next dev version
git checkout develop
echo -e "\nUpdating changelog..."
sed -i "s@# Changelog@# Changelog\n\n## xxxx-xx-xx - dev\n\n...@g" CHANGELOG.md
git add CHANGELOG.md
echo -e "\nUpdating version in Dockerfile..."
sed -i "s@ENV DCATAPPLU_VERSION=${NEXT_VERSION}@ENV DCATAPPLU_VERSION=${DRAFT_VERSION}@g" Dockerfile
git add Dockerfile
git commit -m "Set next development version"

echo -e "\nThe new ${VERSION_TYPE} release ${NEXT_VERSION} has been created locally."
