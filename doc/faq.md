# FAQ

## Which version of BEAUti do you use as a guideline?

Version 2.5.0, as can be found in the [install_beast2](https://github.com/richelbilderbeek/beastier/blob/master/R/install_beast2.R) function.

## How to install BEAST2?

```
beastier::install_beast2()
```

## What's the road map?

Currently, `babette` does not have a road map itself, but `beautier` does:

 * [beautier road map](https://github.com/richelbilderbeek/beautier/blob/master/road_map.md)

## How can I indicate a feature that I miss?

Submit an Issue.

## How can I submit code?

See [CONTRIBUTING](../CONTRIBUTING.md), at 'Submitting code'

## How can I submit a bug?

See [CONTRIBUTING](../CONTRIBUTING.md), at 'Submitting bugs' 

## How can I indicate something else?

Submit an Issue. Or send an email to Richel Bilderbeek.

## How do I reference to this work?

```
Bilderbeek, Richel JC, and Rampal S. Etienne. "babette: BEAU ti 2, BEAST 2 and Tracer for R." Methods in Ecology and Evolution (2018).
```

or

```
@article{bilderbeek2018babette,
  title={babette: BEAUti 2, BEAST 2 and Tracer for R},
  author={Bilderbeek, Richel JC and Etienne, Rampal S},
  journal={Methods in Ecology and Evolution},
  year={2018},
  publisher={Wiley Online Library}
}
```

## Why the name?

 * `ba`: BeAutier
 * `bet`: BEasTier
 * `te`: TracErer

Later on, `mauricer` got added.

## Why the logo?

Initially, the logo was a low-tech remake of Babette, a maid in Beauty and the Beast. 
To prevent problems with Disney, a different logo was picked.

The current logo shows a swan, an animal considered to be graceful.
The swan is drawn by Jose Scholte, who kindly allowed her work to
be used for free, by attribution.

## What are the FASTA files?

FASTA files `anthus_aco.fas` and `anthus_nd2.fas` from:
 
 * Van Els, Paul, and Heraldo V. Norambuena. "A revision of species limits in Neotropical pipits Anthus based on multilocus genetic and vocal data." Ibis.

Thanks to Paul van Els.

## If I set a fixed crown age with multiple alignments, only the first alignment has so

Correct. This is a feature of BEAST2, which I assume is right. 

## Are there any related packages?

 * [lumier](https://github.com/richelbilderbeek/lumier): Shiny app to help create the function call needed
 * [BEASTmasteR](https://github.com/nmatzke/BEASTmasteR): tip-dating analyses using fossils as dated terminal taxa
 * [RBeast](https://github.com/beast-dev/RBeast): misc other things

## What are the dependencies?

![babette dependencies](dependencies.png)
