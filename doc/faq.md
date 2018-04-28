# FAQ

## Which version of BEAUti do you use as a guideline?

Version 2.4.8.

## How to install BEAST2?

See [how to install BEAST2](https://github.com/richelbilderbeek/beastier/blob/master/install_beast2.md).

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

Article is still in preperation.

## Why the name?

 * `ba`: BeAutier
 * `bet`: BEasTier
 * `te`: TracErer

Additionally, the Dutch actress Babette van Veen, is the
voice of an audiobook 'Woezel en Pip', which is about two
beasts. Not only that, in her role in the Dutch soap 
series 'Goede Tijden Slechte Tijden' see had a bestial
personality, as she tried to seduce the good Arnie to cheat
on his sweet girlfriend Roos.

## What is the idea behind the logo?

The logo consists of a rough redraw of Babette, from the Disney animated
movie 'Beauty and the Beast', and the R logo. 

## What are the FASTA files?

FASTA files `anthus_aco.fas` and `anthus_nd2.fas` from:
 
 * Van Els, Paul, and Heraldo V. Norambuena. "A revision of species limits in Neotropical pipits Anthus based on multilocus genetic and vocal data." Ibis.

Thanks to Paul van Els.

## If I set a fixed crown age with multiple alignments, only the first alignment has so

Correct. This is a feature of BEAST2, which I assume is right. 

## Are there any related packages?

Use [BEASTmasteR](https://github.com/nmatzke/BEASTmasteR) for tip-dating analyses using fossils as dated terminal taxa.

Use [RBeast](https://github.com/beast-dev/RBeast) for other things.

## Why the logo?

Initially, the logo was a low-tech remake of Babette, a maid in Beauty and the Beast. 
To prevent problems with Disney, a different logo was picked.

The current logo shows a swan, an animal considered to be graceful.
The swan is drawn by Jose Scholten, who kindly allowed her work to
be used for free, by attribution.

## How did you convert the fuzzy white background to one single color?

```
convert swan.png -fuzz 15% -fill white -opaque white swan_mono_background.png
convert swan_mono_background.png -background white -alpha remove swan_mono_background_2.png
```