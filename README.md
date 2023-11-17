# README

Create a service in `ingest.rb` that can take in `org_chart.csv`. After processing it there should be a record in the users table for each DRI and each contributor, and a record in the squads table for each squad/chapter/group/department. 

A contributor is a member of the left-most team in its row. A DRI is not a member of a squad.

After creating a service that can ingest it, create a service (`export.rb`) that can export a CSV back out that matches the org_chart.csv. It does not need to be in the same order for rows, but the squads should be in the same column as what they are in the original csv.