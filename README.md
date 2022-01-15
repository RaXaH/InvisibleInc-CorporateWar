# InvisibleInc-CorporateWar
### Mod for Invisible, Inc. by Klei Entertainment, altering the strategic layer of the campaign.

This mod aims to extend the playtime of a single campaign playthrough, while giving the player more active options on the macro side (map-screen) of the game.

## Planned gameplay features

**Situations**

Situations are not completed in a linear way, but can be attempted in parallel. This gameplay is supported by a bigger agency and encourages 
the player to sent different agents to different missions. The player must also decide for a mission, if he wants to sent the maximum of four agents to a mission,
or if he wants to hold agents back, so he can attempt more missions.

* Situations need to be breached by Incognita first, before they can be attempted.
* Agency can hold more agents.
* An agent loadout of up to four agents can be tasked a breach.
* Any agent breaching is unavailable for any other actions.
* Advancing the game time, advances the breaching progress.
* Shorter breaching will result into a harder mission.
* (Maybe) Agents who are not on mission, can do other activities that take time. Like improving their skills.


**Corporations**

The corporations are not sleeping. They will develope powerful powerups over time, increasing difficulty as the campaign advances. This will apply pressure onto
the players strategic decisions. If the player advances too slow, he might get overwhelmed by the corporation's power. This will also result into more unique missions,
since every corporation advances on their own, developing their own strengths.

* Advancing the game time, advances the corporations experience (xp).
* Attempting a mission, advances that region's corporation xp.
* Killing guards or leaving the mission on high alarm level will advance that corporation's xp.
* A corporation will gain a new buff upon reaching a defined xp threshold.


**Agency Personnel**
 
The agency is not working from the jet alone anymore, but now has also some extra foot on the ground. The agency's personnel can be assigned to certain tasks and will
give the regions they are working in a bonus based on their assignment. This gameplay addition is mainly meant to give the player a closer control over what mission
types appear, but also opens up other interesting gameplay-design options like item-crafting or a research tree.

* An employee can be assigned one task at a time, giving the corresponding region a bonus.
* An employee can be transferred to an other region, but will be unable to work on an assignment for a while then.
* Personnel can gather intel towards the detection of a situation (specific type).
* More employees can be either rescued from detention centers or recruited via personnel task.

**Campaign flow/ Time management**

In order to make the added strategic options feel impactful, the campaign's flow is changed and slowed down. The campaign does not have a fixed duration and the
final mission must be found during gameplay. For this reason, two currently existing mission types will be repurposed: Executive Terminals will give a mission lead
instead of a site list. Multiple mission leads of one corporation (2-3?) are needed to unlock that corporation's HQ mission. The HQ missions are the same as the 
former ceo office missions and a final mission lead must be extracted via interrogation of the ceo. After collecting 3-4? leads, the final mission will be unlocked.
Incognitas power decay is reworked into a "doom-meter". In order to keep Incognita running, the player must periodically complete a "Power plant" mission to retrieve
a power cell. If Incognita runs out of power, the campaign is lost, adding additional pressure onto the player on the strategic layer.

* No more fixed campaign duration.
* Executive Terminal repurposed to a goal mission.
* CEO Office repurposed to a goal mission.
* Monst3er's shop rework to offer certain items once each day. One of which is an empty passcard.
* Empty passcards can be written on at consoles. After x writes it will convert to a vault access card.
* Incognita starts at 100% Power (Or less if defined in options).
* Advancing time will decrease Incognita's power.
* If dlc is enabled the mid2 mission will appear at 50% power. After that "Power Plant" missions are available to boost Incognita's power.
* Breaching missions will decrease Incognita's power. The more agents are present in a breach, the more power is lost.
* Incognita will suffer inmission debuffs under certain power thresholds.
* (Maybe) The game starts with a special mission (Invisible, Inc. HQ Raid).


## Contribution

If you want to contribute to this project, you are very welcome to do so by any means. May it be coding, game art, story writing or gameplay ideas. Best start to join
would be the [Invisible, Inc. Discord](https://discord.gg/nP5dKKvubh) in the "mod corner". If you contribute, please stay roughly in line with the aforementioned
concept. If you need a more concrete task for your contribution, check the list below.

## Checklist

**New Missions/ Customized Missions** - *Spyface*, *lua*
* [ ] Invisible, Inc. HQ Raid Mission
* [ ] Power Plant Mission
* [ ] Executive Terminal alteration
* [ ] CEO Office alteration

**Game Art** - *kanim*, *image editing software of your choice*
* [ ] Profiles for agency employees
* [ ] In-game art + animations for agency employees
* [ ] Props for the new mission types
* [ ] Icons for several things (corp buffs, corp level emblem, response level emblem, ...)

**Story Telling**
* [ ] Adjustment of the main story line to fit the altered campaign
* [ ] Additional banter for the new missions

**Coding** - *lua*
* [ ] Core gameplay elements
* [ ] Corporation buffs (aka guardDaemons in code)
* [ ] Personnel activities
* [ ] Popular community mods integration (Programs Extended, Advanced Guard Protocol, Neptune Corporation)
