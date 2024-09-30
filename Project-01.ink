/*
    Project 01
    
    Requirements (for 15 base points)
    - Create an interactive fiction story with at least 8 knots 
    - Create at least one major choice that the player can make
    - Reflect that choice back to the player
    - Include at least one loop
    
    To get a full 20 points, expand upon the game in the following ways
    [+2] Include more than eight passages
    [+1] Allow the player to pick up items and change the state of the game if certain items are in the inventory. Acknowledge if a player does or does not have a certain item
    [+1] Give the player statistics, and allow them to upgrade once or twice. Gate certain options based on statistics (high or low. Maybe a weak person can only do things a strong person can't, and vice versa)
    [+1] Keep track of visited passages and only display the description when visiting for the first time (or requested)
    
    Make sure to list the items you changed for points in the Readme.md. I cannot guess your intentions!

*/

VAR name = " "
VAR first_choice = " "
VAR health = 5
VAR time = 0
VAR armour_equip = 0



--> start 

== start ==
You have awaken in a strange place. What shall you call yourself, traveler?
* [Khaliban]
    ~ name = "Khaliban"
        -> start_real
* [Kearan] 
    ~ name = "Kearan"
        -> start_real
* [Flor] 
    ~ name = "Flor"
        -> start_real


== start_real ==
{name == "Flor": What a lovely name. Best of luck on your travels~| }
You stand in an open  field. In the distance you hear the roaring waves of the ocean, and the tall grass sways at your feet. The sky is clear, but something feels off.. 

* [Look left]
    ~ first_choice = "Look left"
        -> second_scene
* [Look right] 
    ~ first_choice = "Look right"
        -> second_scene
* [Draw weapon] 
    ~first_choice = "Draw weapon"
        -> second_scene
        

== second_scene ==
Your ears pick up a low growl behind you. Myrkio is known for its' large creatures, and they're not the friendlest.
+ [Run away] -> run_away
+ [Hide in foliage] -> idiot_move
* [Drink elixir] -> elixir
* [Equip armour] -> armour
* {armour_equip > 0} [Face the creature head on] -> boss_scene

== elixir ==
~ health = health + 3
in a split second decision you uncap the bottle of elixir you bought a few villages back. You gain 3 health because of this. 
Health: {health}
+ [Go Back] -> second_scene
-> DONE

== armour ==
~ armour_equip = armour_equip + 1
Your defense has increased by {armour_equip} because of your shiny new armour! You look stylish, maybe you'll find a maiden after all.. anyways.
+ [Go Back] -> second_scene
-> DONE

== run_away ==
Without a trusty steed you are no match for the beast. It swoops you up in its giant arms and the rest is something you would never be allowed to tell in children's books..
-> DONE

== idiot_move ==
It's morning and the temperature increases as the sun rises above you. What shall you do {name}... the bushes aren't very comfy afterall.
+ [Venture out again] -> second_scene
+ [wait it out] -> wait_more
    ~ time = time + 1 
    * { time == 1 } [stay and sleep more] -> wait_more
{ time_loop() }
-> DONE

== wait_more ==
it is { time_loop() }
~ time = time + 1
+ [lay down and sleep more] -> one_more_wait
+ [GO BACK] -> idiot_move

== one_more_wait ==
it is { time_loop() }
+ [stay hidden] -> idiot_move
+ [venture out] -> boss_scene

== boss_scene ==
A creature that would make any experienced assassin melt at the knees appears before you. God he smells bad.
* {health > 5} [Dodge and attack from behind] -> win_boss
+ [Dodge and attack his legs] -> loss_boss
-> DONE

== loss_boss ==
Nice try, but did you really think that would work, {name}?
You take damage from his powerful hit to your abdomen.
~ health = 0
you have {health} health . 
-> DONE

== win_boss ==
The creature stumbles and lets our one last noise, distressed and defeated it falls to the ground. Good work {name}, the village of Myrkio thanks you..
-> DONE

== function time_loop ==

    ~ time = time + 1
      
    {
        - time > 2:
            ~ time = 0
    }    
    
    {    
        - time == 0:
            ~ return "it's night now, the weather is grey and it would be too cold to wander."
        
        - time == 1:
            ~ return "it's evening, and the wind chill is far to dangerous to explore in."
        
        - time == 2:
            ~ return "it's morning, and the temperature increases with the rising sun."
    
    }

    ~ return time