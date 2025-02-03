Promt: Pravim igricu u godotu zvanu "Corruption Simulator". Ideja je da ti si igrac koji bira drzavu, ime i prezime, svoje atribute i postajes predsednik te drzave. U toj drzavi se desavaju protesti od studenata, gradjana, vojske, i ostalih drustvenih zajednica. Ti kao predsednik moras da suzbijes te proteste. Mozes na dosta raznih nacina kao sto su : dogovor (ispunjenje uslova protestanata), propagandom, nasilno, poslati batinase, lazima u vestima, potkupljivanje poznatih licnosti i slicno. Hocu da igrica bude u fazonu na Age Of Civilizations 2. Da ima next turn i da vreme tece. hocu da ima sistem moralnosti. Hocu da kada se narod prebije da to moze doci do toga da se jos vise naroda pobuni i udje u protest, medjutim ako se previse utera strah ti postajes diktator i mnogo je teze da se napravi protest ali je veca sansa da te ubiju i tako se  zavrsava igrica(moras vise para trositi na obezbedjenje i vojsku da te stiti). Poenta je da ne budes skinut sa vlasti na koji god nacin mozes da se izboris sa protestima. Uzroci protesta mogu biti svasta : Od korupcije, nekvalifikovanih ljudi na visokim pozicijama u drzavi, zbog saradnje sa kriminalcima, zbog zakonski nepravilnih gradjevina, zbog prekrsaja ustava i slicno. Za sada sam vec napravio nesto i cilj mi je prvo prototip da napravim da radi pa cu kasnije detaljnije praviti igricu. PS. ne znam da programiram pa mi treba tvoja pomoc.
Enhanced Promt : Corruption Simulator - Prototype Design
1. Core Concept
"Corruption Simulator" is a turn-based strategy game inspired by classic games like Age of Empires 2. The player assumes the role of a newly elected president (or leader) of a fictional country. Their primary goal is to maintain power despite various challenges, including protests from different societal groups such as students, citizens, military personnel, business owners, etc. Players must navigate through these challenges using strategies that involve negotiation, propaganda, bribery, intimidation, and even brute force.

The game features:

A moral system where decisions affect how players are perceived by their population.
Turn-based gameplay with dynamic events that evolve over time.
Randomized variables affecting economic stability, public opinion, international relations, and internal conflicts.
2. Key Features
Here’s what the game should include:

2.1 Character Creation
At the start of the game, players can customize their character:

Country Selection : Choose one of several predefined countries, each with unique traits (e.g., resource abundance, political instability, cultural diversity).
Name & Surname : Customize the leader's identity.
Attributes : Assign points to attributes such as Charisma, Intelligence, Ruthlessness, Diplomacy, and Wealth. These attributes influence available actions and outcomes.
2.2 Turn-Based Gameplay
Each turn represents a period of time (e.g., months or years), during which:

Events occur based on randomization and previous decisions.
Players make choices about how to handle protests, manage resources, and maintain control.
Time progresses, and consequences unfold.
2.3 Protest Mechanic
Protests arise due to specific grievances, such as:

Corruption scandals.
Poor governance (e.g., unqualified officials in high positions).
Illegal activities (e.g., collusion with criminals, unconstitutional actions).
Economic hardship (e.g., inflation, unemployment).
Players respond to protests using one or more strategies:

Negotiation/Diplomacy : Meet demands partially or fully to calm protesters.
Propaganda : Manipulate media narratives to discredit protesters or sway public opinion.
Intimidation : Deploy police or paramilitary forces to suppress demonstrations.
Bribery/Co-opting Leaders : Pay off protest leaders or influential figures to end unrest.
Lies & Deception : Spread misinformation to confuse or divide opposition groups.
2.4 Moral System
A morality meter tracks the player's reputation:

High Morality: Positive public perception but limited ability to use extreme measures.
Low Morality: Negative public perception; increased risk of coups or assassinations but greater flexibility in enforcing authoritarian policies.
Actions impact morality:

Meeting demands = +Morality.
Using violence/intimidation = -Morality.
Engaging in corruption = -Morality.
If morality drops too low, the player becomes a dictator, triggering new challenges:

Increased resistance among oppressed groups.
Higher costs for maintaining security (e.g., hiring mercenaries, expanding surveillance).
Greater likelihood of assassination attempts.
Conversely, if morality remains high, the player may face fewer immediate threats but could struggle with balancing competing interests.

2.5 Resource Management
Players manage finite resources:

Money : Used for bribes, infrastructure projects, and military spending.
Reputation : Influences alliances, foreign aid, and investment.
Public Support : Determines stability and likelihood of rebellions.
Security Forces : Represents the strength of law enforcement and military units.
Resource allocation affects long-term success:

Ignoring public needs leads to growing discontent.
Overspending on security drains funds needed for development.
2.6 Victory Conditions
Winning scenarios include:

Surviving X turns while maintaining power.
Successfully implementing reforms to address underlying issues, reducing protests altogether.
Establishing a stable dictatorship without facing significant rebellion.
Losing scenarios include:

Being removed from office via impeachment, coup, or revolution.
Assassination by dissidents or rivals.
Economic collapse rendering the state ungovernable.
3. Game Mechanics
Below are detailed mechanics to implement:

3.1 Event System
Random events trigger at the beginning of each turn:

Examples: Natural disasters, economic crises, international sanctions, whistleblower leaks exposing corruption.
Each event presents options with trade-offs, influencing morality, resources, and public sentiment.
3.2 Protest Dynamics
Protests escalate or de-escalate depending on player responses:

Successful suppression reduces short-term unrest but increases resentment.
Concessions improve morale temporarily but may embolden future protests.
Ignoring protests risks spreading unrest to other regions or groups.
3.3 Reputation Effects
Player reputation impacts interactions:

High-reputation leaders gain trust and cooperation from allies.
Low-reputation leaders face skepticism and betrayal.
3.4 International Relations
Foreign powers intervene based on player actions:

Supporting dictators might attract allies but alienate democratic nations.
Promoting transparency earns goodwill but limits coercive tactics.
4. Prototype Goals
For the prototype phase, focus on building core functionality:

Basic UI : Include menus for character creation, turn progression, and action selection.
Event Loop : Develop a simple event generator with pre-defined scenarios.
Protest Resolution : Implement basic protest mechanics with three response types (negotiate, intimidate, bribe).
Morality Meter : Add a visual indicator tracking morality changes.
Turn Timer : Simulate passage of time with incremental updates to resources and conditions.
5. Tools & Resources
Since you mentioned not knowing programming, here's how we can approach it:

Use Godot's built-in tools for drag-and-drop scene creation and scripting templates.
Leverage GDScript , Godot's Python-like language, for logic implementation. Start small—focus on understanding variables, functions, and conditional statements.
Utilize free assets from platforms like Kenney.nl or OpenGameArt.org for graphics and sound effects.
6. Next Steps
To begin prototyping:

Sketch out your UI design on paper or digitally.
Define initial events and protest triggers.
Create placeholder assets (text boxes, buttons, icons).
Write pseudocode for key systems (event loop, protest resolution, morality tracker).
Gradually translate pseudocode into GDScript within Godot.
