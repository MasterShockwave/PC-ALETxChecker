This repo contains the latest script that I am using to detect when PC-ALE is about to go into transmit, then send a CAT control command to a connected rig.
A major drawback to using PC-ALE for ham radio is that many rigs are not capable of 'quiet-scanning'. This script is part of a developmental work-around which uses an RTL-SDR dongle and SDRSharp to scan, while only using the HF rig for transmitting.
My current rig is a Xiegu G90, hence some of the variable names.

This project is a work in progress. Please see the Documentation folder for notes and a setup guide for use of an RTL-SDR for this purpose. I think this approach has the potential to lower the 'barrier to entry' into ALE for ham radio, and encourage a lot of ham operators to try ALE as a tool.
My physical setup is only marginally more complex than setting up other HF digital modes such as FT8.

A video showing this script in action - https://youtu.be/JHfIC8SY_q4
