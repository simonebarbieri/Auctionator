#!/usr/bin/python3
import csv

enchants_only = {}

with open('item.csv', newline='') as f:
    reader = csv.DictReader(f, delimiter=',')
    for row in reader:
        if row['ClassID'] == '8': # Item Enhancement
            itemID = int(row['ID'])
            enchants_only[itemID] = []

with open('itemxitemeffect.csv') as f:
    reader = csv.DictReader(f, delimiter=',')
    for row in reader:
        itemid = int(row['ItemID'])
        if itemid in enchants_only:
            enchants_only[itemid].append(int(row['ItemEffectID']))

effects_to_spell = {}
with open('itemeffect.csv') as f:
    reader = csv.DictReader(f, delimiter=',')
    for row in reader:
        effects_to_spell[int(row['ID'])] = int(row['SpellID'])


def print_enchant(itemID, spellID):
    print("  [" + str(spellID) + "] = " + str(itemID) + ",")

print("Auctionator.CraftingInfo.EnchantSpellsToItems = {")
for key in enchants_only:
    itemeffects = enchants_only[key]

    if len(itemeffects) == 1:
        print_enchant(key, effects_to_spell[itemeffects[0]])
print("}")
