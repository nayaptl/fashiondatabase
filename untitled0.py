# -*- coding: utf-8 -*-
"""
Created on Thu May 20 03:41:46 2021

@author: NAGIA
"""

# Module Imports
import mariadb
import sys
import pygame as pg
import box as bx

pg.init()
size = width, height = 900, 500

# Colors
black = (0, 0, 0)
white = (255, 255, 255)
COLOR_INACTIVE = pg.Color('lightskyblue3')
COLOR_ACTIVE = pg.Color('dodgerblue2')
screen = pg.display.set_mode(size)

mediumFont = pg.font.Font("OpenSans-Regular.ttf", 14)



# Connect to MariaDB Platform
try:
    conn = mariadb.connect(
        user="root",
        password="student",
        host="127.0.0.1",
        port=3306,
        database="fashiondb"

    )
except mariadb.Error as e:
    print(f"Error connecting to MariaDB Platform: {e}")
    sys.exit(1)

# Get Cursor
cur = conn.cursor()

while True:
    input_box1 = bx.InputBox(350, 400, 140, 32)
    
    for event in pg.event.get():#checks if he wants to quit game
        if event.type == pg.QUIT:
            conn.close()
            sys.exit()
        input_box1.handle_event(event)
        
    input_box1.update()
    screen.fill(black)
        
    input_box1.draw(screen)
    
    

    

    #print all factory names
    try:
        cur.execute("SELECT name FROM factory ")
    except mariadb.Error as e:
        print(f"Error: {e}")
    i=0  
    for name in cur:
        i+=1
        text = mediumFont.render(f"name of {i} factory: {name}", True, white)
        textRect = text.get_rect()
        textRect.center = ((width / 2), 10+(i*14))
        screen.blit(text, textRect)
        
        
    try:
        cur.execute("SELECT name FROM factory  WHERE location=? ",("england",))
    except mariadb.Error as e:
        print(f"Error: {e}")
        
    for name in cur:
        text1=f"name of factory in england is: {name}"
    
    text = mediumFont.render(text1, True, white)
    textRect = text.get_rect()
    textRect.center = ((width / 2), 150)
    screen.blit(text, textRect)
        
    try:
        cur.execute("SELECT name, factory_ID FROM factory JOIN Factory_Has_Supplier ON factory.factory_ID=Factory_Has_Supplier.factorycode WHERE suppliercode=?",("134521675",))
    except mariadb.Error as e:
        print(f"Error: {e}")
        
    for name in cur:
        text1=f"name and id of factory that works with supplier, which ID is 186426846: {name}"
        
    text = mediumFont.render(text1, True, white)
    textRect = text.get_rect()
    textRect.center = ((width / 2), 170)
    screen.blit(text, textRect)
    
    try:
        cur.execute("SELECT name, factory_ID FROM factory JOIN Factory_Has_Supplier ON factory.factory_ID=Factory_Has_Supplier.factorycode WHERE suppliercode=?",("134521675",))
    except mariadb.Error as e:
        print(f"Error: {e}")
        
    for name in cur:
        text1=f"name and id of factory that works with supplier, which ID is 186426846: {name}"
        
    text = mediumFont.render(text1, True, white)
    textRect = text.get_rect()
    textRect.center = ((width / 2), 170)
    screen.blit(text, textRect)
    
    #Find all the clients (ID, name) that ordered bags  of category 2 
    try:
        cur.execute("SELECT client.client_ID, client.name FROM bags JOIN fashiondb.`order` ON bags.product_ID=`order`.productcode JOIN client ON `order`.clientcode=client.client_ID WHERE category=?",(2,))
    except mariadb.Error as e:
        print(f"Error: {e}")
    i=0   
    for name in cur:
        i+=1
        text1=f"the {i} client that ordered bags  of category 2 are: {name}"
        text = mediumFont.render(text1, True, white)
        textRect = text.get_rect()
        textRect.center = ((width / 2), 190+(i*14))
        screen.blit(text, textRect)
        
        
    #Find the list (all data) of all the dresses.
    try:
        cur.execute("SELECT * FROM dress LEFT JOIN product ON dress.product_ID=product.product_ID")
    except mariadb.Error as e:
        print(f"Error: {e}")
    i=0   
    for name in cur:
        i+=1
        text1=f"the {i} dress : {name}"
        text = mediumFont.render(text1, True, white)
        textRect = text.get_rect()
        textRect.center = ((width / 2), 230+(i*14))
        screen.blit(text, textRect)
        
    
        
    
    
        
    pg.display.flip()
        
    
    
    
        


