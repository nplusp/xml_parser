# Honeycomb Engineering Test

## Dependencies
* Ruby 2.3
* Postgres

## Goal

The aim of this test is to see how you tackle an engineering challenge; how you approach the work, what tools and techniques you select, how you ensure the quality of the code produced.

## The challenge

We want to get XML metadata via http from two sources:

* [Supplier One](private)
* [Supplier Two](private)

Once we have the data in our system want to be able to edit the title, episode, year, duration and aspect ratio in a web form.

Finally we want to make this information available for other systems to GET as JSON at an http endpoint. The information we want to present in this JSON is the name of the supplier, the title and duration.

In addition we want this JSON representation to include a history of the edits made to the data via the web form. This should list the time/date the edit was made and which field was changed.
