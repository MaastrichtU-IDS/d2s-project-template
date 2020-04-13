#!/bin/bash

wget -N ftp://ftp.nlm.nih.gov/online/mesh/rdf/mesh.nt.gz
wget -N ftp://ftp.nlm.nih.gov/online/mesh/rdf/void_1.0.0.ttl
wget -N ftp://ftp.nlm.nih.gov/online/mesh/rdf/vocabulary_1.0.0.ttl
wget -N ftp://ftp.nlm.nih.gov/online/mesh/rdf/service_description.ttl

find . -name "*.gz" -exec gzip -d  {} + >
