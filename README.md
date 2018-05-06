# Jtransit

## Inroduction
Traffic influence not only economic activity, but also human bahavior. In our daily life, we use car, rail way, bus and go anywhere walk and railway from your home. 
It is very important to understand traffic system, especially service area. Service areas created by Network Analyst also help evaluate accessibility. Concentric service areas show how accessibility varies with impedance.
To create service area, we have to gather transit dara. Except Japan, it is possible to get the transit data(duration, fare...) from google API. Also ArcGIS provide some function to create service area. However, it is very expensive for student. So this package provide some function to get transit data from yahoo transit service.
The aim of this package is creating service area.

![](http://john-coene.com/ig/graphTweets.png)

Visualise networks of Twitter interactions.

* [Install](#install)
* [Documentation](#documentation)
* [Features](#features)
* [Rationale](#rationale)
* [Examples](#examples)

**Updated the package to better suit `rtweets`**

## Install

```R
install.packages("graphTweets") # CRAN release v0.4
devtools::install_github("JohnCoene/graphTweets") # dev version
```

## Documentation 

* [Examples](http://graphtweets.john-coene.com/)

## Features

*`v4`*

- `gt_edges` - get edges.
- `gt_nodes` - get nodes, with or without metadata.
- `gt_dyn` - create dynamic graph.
- `gt_graph` - create `igraph` graph object.
- `gt_save` - save the graph to file
- `gt_collect` - collect nodes and edges.

See `NEWS.md` for changes.

## Rationale

Functions are meant to be run in a specific order.

1. Extract edges
2. Extract the nodes

One can only know the nodes of a network based on the edges, so run them in that order. However, you can build a graph based on edges alone:

```R
library(igraph) # for plot

tweets %>% 
  gt_edges(text, screen_name, status_id) %>% 
  gt_graph() %>% 
  plot(., vertex.size = degree(.) * 10)
```

This is useful if you are building a large graph and don't need any meta data on the nodes (other than those you can compute from the graph, i.e.: `degree` like in the example above). If you need meta data on the nodes use `gt_nodes`.

```R
library(igraph) # for plot

tweets %>% 
  gt_edges(text, screen_name, status_id) %>% 
  gt_nodes(meta = TRUE) %>% # set meta to TRUE
  gt_graph() -> g 

# replace NAs
V(g)$followers_count <- ifelse(!is.na(V(g)$followers_count), V(g)$followers_count, 1)
  
plot(g, vertex.size = log1p(V(g)$followers_count)) # size nodes by follower count.
```

## Examples

```R
library(rtweet)

# Sys.setlocale("LC_TIME", "English")

tweets <- search_tweets("#rstats")

library(graphTweets)

# simple network
tweets %>% 
  gt_edges(text, screen_name, status_id) %>% # get edges
  gt_nodes %>% # get nodes
  gt_graph %>% # build igraph object
  plot(.)

# dynamic graph
tweets %>% 
  gt_edges(text, screen_name, status_id, "created_at") %>% # add created time
  gt_nodes(TRUE) %>%
  gt_dyn %>% # make dynamic
  gt_save # save as .graphml
```
