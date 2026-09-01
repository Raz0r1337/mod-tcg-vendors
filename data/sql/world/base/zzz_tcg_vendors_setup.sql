-- mod-tcg-vendors: world database setup
-- Apply to: world database
--
-- What this script does:
--   1. Creates npc_text entries for the greeting dialog of each NPC type.
--   2. Sets the ScriptName on the three NPC creature_template rows so the
--      server loads our C++ gossip handlers.
--   3. Ensures all three NPCs have the UNIT_NPC_FLAG_GOSSIP flag (bit 1)
--      so right-clicking them opens a gossip dialog.
--
-- IMPORTANT: Run this AFTER applying the characters DB SQL.
-- IMPORTANT: Verify that npc_text IDs 90001 and 90002 are not already in
--            use on your server before applying. If they are, change the
--            IDs here AND in the TCGNpcTextIds enum in mod_tcg_vendors.cpp.

-- ============================================================
--  Place Garel and Gurky in The Forlorn Cavern, and rotate Murky to Match Ransin
-- ============================================================

-- Garel Redrock
DELETE FROM `creature` WHERE (`id` = 16070);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(700000, 16070, 0, 0, 0, 1, 1, 0, -4641.38, -1106.84, 501.306, 0.746907, 300, 0, 0, 1220, 0, 0, 0, 0, 0, '', 0, 0, NULL);

-- Gurky (The Pink Baby Murloc)
DELETE FROM `creature` WHERE (`id` = 16069);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(6498, 16069, 1, 0, 0, 1, 1, 0, 1989.83, -4656.83, 27.6781, 0.628319, 120, 0, 0, 42, 0, 0, 0, 0, 0, '', 0, 0, NULL),
(700001, 16069, 0, 0, 0, 1, 1, 0, -4639.76, -1107.97, 501.32, 0.64638, 120, 0, 0, 42, 0, 0, 0, 0, 0, '', 0, 0, NULL);

-- Rotate Murky (The Blue Baby Murloc) next to Ransin Donner
DELETE FROM `creature` WHERE (`id` = 15186);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(1792, 15186, 0, 0, 0, 1, 1, 0, -4638.07, -1109.05, 501.427, 0.628319, 300, 0, 0, 42, 0, 0, 0, 0, 0, '', 0, 0, NULL),
(6493, 15186, 1, 0, 0, 1, 1, 0, 1992.19, -4651.05, 27.3074, 6.14356, 120, 0, 0, 42, 0, 0, 0, 0, 0, '', 0, 0, NULL);


-- ============================================================
--  NPC greeting text
-- ============================================================

-- Landro Longshot
DELETE FROM `npc_text` WHERE `ID` = 90001;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`) VALUES
(
    90001,
    'Landro Fernblick, die Schwarze Flamme, zu Euren Diensten, $N.$B$BIhr wollt also einen Code für das World of Warcraft Sammelkartenspiel einlösen? Nennt mir das Set, aus dem Eure Karte stammt, und ich regle den Rest.',
    ''
);

-- Ransin Donner / Zas'Tysh  (shared text)
DELETE FROM `npc_text` WHERE `ID` = 90002;
INSERT INTO `npc_text` (`ID`, `text0_1`, `text0_0`) VALUES
(
    90002,
    '',
    'Willkommen, $N. Ich verwalte die offiziellen Promo-Codes von Blizzard.$B$BJeder Code kann nur einmal eingelöst werden. Sagt mir, für welchen Gegenstand Ihr gekommen seid.'
);

--  Garel Redrock / Tharl Stonebleeder  (promotional item vendors)
DELETE FROM `npc_text` WHERE `ID` = 90003;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`) VALUES
(
    90003,
    'Willkommen, $N. Ich kann Euch eine ganze Reihe exklusiver Promo-Begleiter und besonderer Gegenstände beschaffen.$B$BJeder Gegenstand kann pro Charakter nur einmal eingelöst werden. Stöbert nach Kategorie, um zu finden, wonach Ihr sucht.',
    ''
);

--  Edward Cairn (Horde, Undercity) and Ian Drake (Alliance, Stormwind)
DELETE FROM `npc_text` WHERE `ID` = 90004;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`) VALUES
(
    90004,
    'Seid gegrüßt, $N. Ich nehme an, Ihr bringt mir gute Nachrichten vom Worldwide Invitational? Wenn dem so ist, dann hat man Euch gewiss einen geheimen Code anvertraut, den Ihr mir nennen sollt. Im Tausch für Euren Code gebe ich Euch ein Geschenk: Tyraels Schwertgriff.$B$BFlüstert ihn mir einfach ins Ohr, sobald Ihr bereit seid.',
    ''
);

-- ============================================================
--  Assign script names
-- ============================================================
UPDATE `creature_template`
    SET `ScriptName` = 'npc_landro_longshot'
    WHERE `entry` = 17249;

UPDATE `creature_template`
    SET `ScriptName` = 'npc_blizzcon_vendor'
    WHERE `entry` IN (2943, 7951);

UPDATE `creature_template`
    SET `ScriptName` = 'npc_promo_vendor'
    WHERE `entry` IN (16070, 16076);

UPDATE `creature_template`
    SET `ScriptName` = 'npc_tyraels_vendor'
    WHERE `entry` IN (29095, 29093);

-- ============================================================
--  Ensure NPCs have the gossip NPC flag set  (bit 1 = 0x1)
-- ============================================================
UPDATE `creature_template`
    SET `npcflag` = `npcflag` | 1
    WHERE `entry` IN (17249, 2943, 7951, 16070, 16076, 29095, 29093);
