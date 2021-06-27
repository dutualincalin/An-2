Pentru a instala PSQueue rulați în terminal:
      stack install PSQueue

Pentru rularea testelor:
      stack exec ghci TestMTS.hs (dacă ați adăugat dependința pentru PSQueue în stack.yml)
      stack exec ghci --package PSQueue TestMTS.hs (altă variantă de rulare)
 
      *TestMTS.hs> checkAll                            ---> rulează toate testele 
      *TestMTS.hs> vmCheckIO [ lista_teste_de_rulat ]  ---> rulează o suită de teste,
                                                            cu valori din următorul domeniu:
                                                    [ testEmptyGame,
                                                      testAddHunter,
                                                      testAddGateway,
                                                      testAddTarget,
                                                      testAddObstacle,
                                                      testAddAll,
                                                      testBehaviors,
                                                      testIsTargetKilled,
                                                      testAdvanceGame,
                                                      testSuccessors,
                                                      testIsGoal,
                                                      testCreateStateSpaceTree,
                                                      testSuitableSuccessors,
                                                      testInsertSuccs,
                                                      testAStarTreeGoal,
                                                      testAStarTreePath,
                                                      testSolveGame
                                                    ]

Pentru a juca în linia de comandă:
      stack exec ghci Interactive.hs (dacă ați adăugat dependința pentru PSQueue în stack.yml)
      stack exec ghci --package PSQueue Interactive.hs (altă variantă de rulare)
 
      *Interactvie.hs> interactive $ loadGame "terrains/terrain-1.txt" [goNorth, goSouth] [(0, 1)]
                        --> pornește în linia de comandă jocul pentru terenul 1
                        --> inchideti folosind CTRL + C

      *Interactvie.hs> hunt True $ loadGame "terrains/terrain-1.txt" [goNorth, goSouth] [(0, 1)]
                        --> pornește în linia de comandă jocul pentru terenul 1
                        --> apăsați ENTER pentru a rula următoare mișcare aleasă de A*
      
      
