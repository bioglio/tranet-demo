# Inspiration Rate Demo

Information diffusion is a widely-studied topic: in bibliographic networks, an information diffusion process takes place when some authors, that publish papers in a given topic, influence some of their neighbors (coauthors, citing authors, collaborators) to publish papers in the same topic, and the latter influence their neighbors in their turn. In this kind of networks, influential topics are usually considered those ones that spread most rapidly in the network. Although this is generally a fact, this semantics does not consider that topics in bibliographic networks evolve continuously. 

Here a new definition of influence is proposed, able to capture the the diffusion of inspiration within the network. Such technique is employed here to detect the most inspiring topics in a citation network built upon a large bibliographic dataset.

## How it works

First, we use an adaptive LDA technique for assigning topics to each publication in our dataset, available [here](https://datacloud.di.unito.it/index.php/s/ymSe23wGp1z7aLg/download).

![How innovation score works](https://datacloud.di.unito.it/index.php/s/AgFEOHSoOgUXNnC/download)

For a topic _t_, we select all the papers published on _t_ during a range of years _R(0)_. Then we select all the papers published during the range of years _R(1)_, subsequent to _R(0)_, on topic _t_ that cites any of the papers in _R(0)_. We repeat the procedure for several ranges of years: for range of years _R(i)_, we select all the papers published on topic _t_ during this period that cites any of the papers in the previous range of years, _R(i-1)_. After this loop, we have a set of papers for each range of years: from these sets we create the sets of authors that have published a paper in topic _t_ and have cited a paper in the previous time window. We count the number of new authors in these sets, that is the authors in a set that are not included in the set of the previous time ranges: each value states the number of new authors that have published in _t_ inspired by the authors in the previous time window.

For ranking topics, we collect the cumulative over time windows of such values, we fit the curve with a linear function and we employ the slope of the fitted curve as score of diffusion rank.


## What is contained in this notebook

The notebook does not cover topic assignment and rank calculation: you can find the complete code of these processes [here](https://github.com/rupensa/tranet). Here you can find analysis on the dataset of citations (like number of papers and authors grouped by year and topic) and on the ranking results. Here we employ as starting time window the range of years from 2000 to 2004, and we study several subsequent time windows until 2014: in particular, time windows have length δ between 1 and 6, and can overlap wih the previous time window (except with _R(0)_) for a value γ lower than δ. We show the difference between inspiration and diffusion, that is the cumulative number of new authors that have publieshed on a topic each year, and correlations of ranking calculates with different values of δ and γ.

## Run the notebook

The notebook is written in python3, and uses the following modules:

- [pandas](https://pandas.pydata.org/)
- [scipy](https://www.scipy.org/)
- [matplotlib](http://matplotlib.org/)
- [seaborn](https://seaborn.pydata.org/)
- [jupyter](http://jupyter.org/)
- [wordcloud](https://github.com/amueller/word_cloud)

It is also possible to run it in a virtual environment or inside a Docker container.

### Run in virtual environment

For running the notebook in a virtual environment, create it:

    virtualenv --python=python3 .venv

then activate it:

    source .venv/bin/activate

Install the dependencies (pandas, scipy, matplotlib, seaborn, jupyter, wordcloud):

    pip3 install -r requirements.txt

Download and unzip data from [here](https://datacloud.di.unito.it/index.php/s/M8KwNk1zussVkos/download)

Finally, launch the jupyter notebook

    jupyter notebook


### Run inside Docker container

This repository contains Dockerfile and can be build into a docker container.

To build the container run the following command from inside of the repository directory:

    docker build -t bioglio/tranet-demo .

Run the container:

    docker run -it -p 8888:8888 bioglio/tranet-demo


If you want to save the results on a local directory (for example ./data), run the container with the command:


    docker run -it -p 8888:8888 -v /$(pwd)/data:/home/jovyan/tranet-demo/data bioglio/tranet-demo


After starting the container, you can access jupyter notebook on browser by means of 
the url furnished by the container, like:

```
http://localhost:8888/?token=37e530e6f29c7c910f8e4c115ae58de9bd8c267a1c03a781
```
