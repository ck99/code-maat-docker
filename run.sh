#! /bin/sh

./_ensure_docker_images.sh

if [ $# -eq 0 ] ; then
    echo 'You need to pass a path to a git repository as an argument'
    exit 1
fi

GITPATH=$1
REPONAME=$(basename ${GITPATH})

printf "Creating docker volume: "
VOLUME=$(docker volume create code-maat-${REPONAME})
printf " done.\n"

printf "Generating gitlog: "
docker run --rm -v ${GITPATH}:/git --mount source=${VOLUME},target=/logs code-maat-gitlogger
printf "done.\n"

BUSYBOX="docker run -it --rm --mount source=${VOLUME},target=/data busybox"
CODEMAAT="docker run --rm --mount source=${VOLUME},target=/data -it code-maat-app --log /data/logfile.log --version-control git2"

#printf "Running analysis summary: "
#$(${CODEMAAT} --analysis summary --outfile /data/analysis-summary.csv)
#printf "done.\n"
#
#${BUSYBOX} cat /data/analysis-summary.csv
#
#printf "Running analysis authors: "
#$(${CODEMAAT} --analysis authors --outfile /data/analysis-authors.csv)
#printf "done.\n"

for analysis in summary authors
do
    printf "Running analysis ${analysis}: "
    $(${CODEMAAT} --analysis ${analysis} --outfile /data/analysis-${analysis}.csv)
    printf "done.\n"
done

printf "Files Generated in docker volume ${VOLUME}:\n"
${BUSYBOX} ls -alh /data