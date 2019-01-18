<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.2" tiledversion="1.2.1" name="cavesofgallet" tilewidth="8" tileheight="8" tilecount="192" columns="16">
 <image source="../assets/textures/cavesofgallet/cavesofgallet_tiles.png" width="128" height="96"/>
 <terraintypes>
  <terrain name="green" tile="8"/>
  <terrain name="brown" tile="33"/>
  <terrain name="grey" tile="34"/>
  <terrain name="black" tile="24"/>
  <terrain name="ladder" tile="103"/>
 </terraintypes>
 <tile id="0" type="wall fill" terrain="3,3,3,3" probability="0.1"/>
 <tile id="1" type="wall fill" terrain="3,3,3,3" probability="0.1"/>
 <tile id="2" type="wall fill" terrain="3,3,3,3" probability="0.1"/>
 <tile id="3" type="wall fill" terrain="3,3,3,3" probability="0.1"/>
 <tile id="4" type="wall fill" terrain="3,3,3,3" probability="0.1"/>
 <tile id="5" type="wall fill" terrain="3,3,3,3" probability="0.1"/>
 <tile id="6" type="wall fill" terrain="3,3,3,3" probability="0.1"/>
 <tile id="7" type="wall fill"/>
 <tile id="8" type="ground green"/>
 <tile id="9" type="ground green"/>
 <tile id="10" type="ground green"/>
 <tile id="15" terrain="0,0,0,0" probability="0.7"/>
 <tile id="16" type="ground green" terrain="0,0,0,3">
  <objectgroup draworder="index">
   <object id="2" x="0" y="0" width="8" height="4"/>
   <object id="3" type="pixel" x="0" y="4" width="4" height="4"/>
  </objectgroup>
 </tile>
 <tile id="17" type="ground green" terrain="0,0,3,3"/>
 <tile id="18" type="ground green" terrain="0,3,3,3"/>
 <tile id="24" type="ground green"/>
 <tile id="25" type="ground green"/>
 <tile id="26" type="ground green"/>
 <tile id="29" terrain="3,0,3,3"/>
 <tile id="30" terrain="0,0,3,3"/>
 <tile id="31" type="red bird" terrain="0,0,3,0"/>
 <tile id="32" type="ground grey" terrain="0,3,0,3"/>
 <tile id="33" type="ground grey" terrain="0,0,0,0" probability="0.1"/>
 <tile id="34" type="ground grey" terrain="0,3,0,3"/>
 <tile id="35" type="ground brown"/>
 <tile id="36" type="ground brown"/>
 <tile id="37" type="ground brown"/>
 <tile id="38" type="red bird"/>
 <tile id="39" type="red bird"/>
 <tile id="40" type="ground grey"/>
 <tile id="41" type="blue bird"/>
 <tile id="42" type="ground grey"/>
 <tile id="43" type="ground brown"/>
 <tile id="44" type="ground brown"/>
 <tile id="45" terrain="3,0,3,0"/>
 <tile id="46" type="ladder" terrain="0,0,0,0"/>
 <tile id="47" type="ladder" terrain="3,0,3,0"/>
 <tile id="48" type="blue bird" terrain="0,3,0,0"/>
 <tile id="49" type="blue bird" terrain="3,3,0,0"/>
 <tile id="50" type="ground grey" terrain="0,0,0,0" probability="0.1"/>
 <tile id="51" type="ground brown"/>
 <tile id="52" type="ground brown"/>
 <tile id="54" type="ladder"/>
 <tile id="55" type="ladder"/>
 <tile id="60" type="lava"/>
 <tile id="62" terrain="3,3,0,0"/>
 <tile id="63" terrain="3,0,0,0"/>
 <tile id="64" type="water" terrain="3,2,3,3"/>
 <tile id="65" type="water" terrain="2,2,3,3"/>
 <tile id="66" terrain="2,2,3,2"/>
 <tile id="67" type="lava" terrain="1,1,1,3"/>
 <tile id="68" type="lava" terrain="1,1,3,3"/>
 <tile id="69" type="steam" terrain="1,3,3,3"/>
 <tile id="70" type="steam"/>
 <tile id="71" type="steam"/>
 <tile id="72" type="water"/>
 <tile id="73" type="water"/>
 <tile id="74" type="water" terrain="3,1,3,3"/>
 <tile id="75" type="water" terrain="1,1,3,3"/>
 <tile id="76" type="lava" terrain="1,1,3,1"/>
 <tile id="77" type="steam" terrain="2,2,2,3"/>
 <tile id="78" type="steam" terrain="2,2,3,3"/>
 <tile id="79" type="steam" terrain="2,3,3,3"/>
 <tile id="80" type="water" terrain="2,3,2,3"/>
 <tile id="81" type="water"/>
 <tile id="82" type="water" terrain="3,2,3,2"/>
 <tile id="83" type="water" terrain="1,3,1,3"/>
 <tile id="84" type="lava"/>
 <tile id="85" type="vine"/>
 <tile id="86" type="vine"/>
 <tile id="87" type="vine" terrain="3,3,4,4"/>
 <tile id="88" type="water" terrain="3,3,4,4"/>
 <tile id="89" type="water"/>
 <tile id="90" type="water"/>
 <tile id="91" type="water"/>
 <tile id="92" type="lava" terrain="3,1,3,1"/>
 <tile id="93" terrain="2,3,2,3"/>
 <tile id="95" terrain="3,2,3,2"/>
 <tile id="98" terrain="3,2,2,2"/>
 <tile id="99" terrain="1,3,1,1"/>
 <tile id="100" terrain="3,3,1,1"/>
 <tile id="103" terrain="4,4,4,4"/>
 <tile id="104" terrain="4,4,4,4"/>
 <tile id="107" terrain="3,3,1,1"/>
 <tile id="108" terrain="3,1,1,1"/>
 <tile id="109" terrain="2,3,2,2"/>
 <tile id="117" terrain="3,3,3,3"/>
 <tile id="185" terrain="2,2,2,2"/>
 <tile id="186" terrain="1,1,1,1"/>
</tileset>
