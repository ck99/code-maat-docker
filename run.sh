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
DOCKERCMD="docker run -it --rm -v ${GITPATH}:/git --mount source=${VOLUME},target=/logs code-maat-gitlogger"
ELAPSED=$(time -f "%E" ${DOCKERCMD} 2>&1)
printf "done. (${ELAPSED})\n"

printf "Generating cloc: "
DOCKERCMD="docker run -it --rm -v ${GITPATH}:/git --mount source=${VOLUME},target=/logs code-maat-cloc /git/ --by-file --csv --quiet --report-file=/logs/cloc.csv"
ELAPSED=$(time -f "%E" ${DOCKERCMD} 2>&1)
printf "done. (${ELAPSED})\n"

BUSYBOX="docker run -it --rm --mount source=${VOLUME},target=/data busybox"
CODEMAAT="docker run -it --rm --mount source=${VOLUME},target=/data code-maat-app --log /data/logfile.log --version-control git2"


#analysis="summary"
#DOCKERCMD="${CODEMAAT} --analysis ${analysis} --outfile /data/analysis-${analysis}.csv"
#printf "Running analysis ${analysis}: "
#ELAPSED=$(time -f "%E" ${DOCKERCMD} 2>&1)
#printf "done. (${ELAPSED})\n"

#$(${BUSYBOX} cat /data/analysis-summary.csv)

AVAILABLEANALYSES=$(docker run --rm -it code-maat-app | grep "analysis to run" | sed 's@.*(\(.*\))@\1@g'| sed 's@,@@g' | xargs echo -n)
for x in ${AVAILABLEANALYSES}
do
    analysis="$(echo $x | tr -d [:space:])";
    if [ "$analysis" = "messages" ]
	then
		continue
	fi
    DOCKERCMD="${CODEMAAT} --analysis ${analysis} --outfile /data/analysis-${analysis}.csv"
    printf "Running analysis ${analysis}: "
    ELAPSED=$(time -f "%E" ${DOCKERCMD} 2>&1)
    printf "done. (${ELAPSED})\n"
done

printf "Files Generated in docker volume ${VOLUME}\n"
${BUSYBOX} ls -alh /data
