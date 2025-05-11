# Why not use V-Slice?

It's a good question, I've got a good answer though, many of them.

Despite V-Slice's shallow featureset it's very overengineered,
from their stubborn desire to use polymod, their many menus that aren't easy to mod at all,
the way scripted versions of objects work, to the chart format itself, no portion of the engine
is safe from what I'd call "overcooking". Every part of this engine is complex to the extreme
when there's no discernable reason for any of it to be. Despite missing out on essential features
on release like actual modded week support until WEEKS after the release of the first update.

Their chart editor is borderline unusable and riddled with bugs, most of them existing for a year. Their character editor
is so barebones that you're better off using the Psych character editor and manually converting the json into their 
format using a text editor. The stage editor is the only decent one and they didn't even make it.

Not to mention how the direction they're taking towards the gameplay of the whole thing, despite it being a 4 judgement rhythm game, 
they decide to make Goods and Sicks essentially the same accuracy grade, with anything lower being treated the same as misses,
which is overkill on it's own, add extreme anti-ghost tapping mixed with Psych styled anti-spam, and you got a recipe for disaster.

The way they treat the API version clause in _polymod_metadata.json is a joke, it completely stops your mod from working despite how in
like Forge and shit, they simply warn you that the creator did not check for compatibility for this version and never nag you about it afterwards,
if I have to update my mods constantly despite no breaking changes being made to my code in the first place because a random hotfix broke something I did not use.
I'm rightfully gonna be pissed about it. Oh and I forgot to mention, they LOVE breaking changes, it could happen between hotfixes, between major updates, it doesn't matter, 
your mod is not lasting 6 months if you make it for V-Slice.