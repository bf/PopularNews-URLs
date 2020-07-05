import os
import tldextract
import numpy as np
import pandas as pd

OUTPUT_DIR = "output"
SEARCH_DIR = os.path.join(OUTPUT_DIR, "temp")

arr_domain_lists = sorted(list(
  filter(
    lambda filename: filename.endswith(".domains.txt"),
    os.listdir(SEARCH_DIR)
  )
))

domains = set()
for filename in arr_domain_lists:
  print("filename", filename)
  lines = np.loadtxt(os.path.join(SEARCH_DIR, filename), 
    dtype=str, unpack=False)
  print("lines", len(lines))

  for entry in lines:
    tld_meta = tldextract.extract(entry)
    domain = tld_meta.registered_domain

    domain = domain.lower()
  
    if entry != domain:
      print("\t", entry, "\n\t -> ", domain)
    domains.add(domain)

  print(len(domains))

# store data
outputFile = os.path.join(OUTPUT_DIR, 
  "all-major-media-outlets.txt")

print("saving to", outputFile)
domains = sorted(list(domains))

df = pd.DataFrame({ "domain": domains })

df.to_csv(outputFile,
  header=False, index=False)

print("written", len(domains), "domains")