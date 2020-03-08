
defmodule Poker do

    def deal(hand) do
        hand1 = getHand1(hand,[], 10)
        hand2 = getHand2(hand,[], 10)

        hand1Simp = simplifyHand(hand1,[])
        hand2Simp = simplifyHand(hand2,[])
 
        # hand1Rank = 0
        # hand2Rank = 0
        
        # if hd(hd(onePair(hand1Simp,[0],[],false))) > hd(hd(onePair(hand2Simp,[0],[],false))) && hd(hd(onePair(hand2Simp,[0],[],false))) != 1 || hd(hd(onePair(hand1Simp,[0],[],false))) < hd(hd(onePair(hand2Simp,[0],[],false))) && hd(hd(onePair(hand1Simp,[0],[],false))) == 1 do
        #     hand1Rank = 1
        # end

        # if hd(hd(onePair(hand1Simp,[0],[],false))) > hd(hd(onePair(hand2Simp,[0],[],false))) && hd(hd(onePair(hand2Simp,[0],[],false))) == 1 || hd(hd(onePair(hand1Simp,[0],[],false))) < hd(hd(onePair(hand2Simp,[0],[],false))) && hd(hd(onePair(hand1Simp,[0],[],false))) != 1 do
        #     hand2Rank = 1
        # end

        # hand1Rank
               
        # cond do
            # fullHouse(Enum.at(onePair(hand1Simp,[0],[],false),1), Enum.at(threePair(hand1Simp,[0],[],false),1), [],[],false) == true && fullHouse(Enum.at(onePair(hand2Simp,[0],[],false),1), Enum.at(threePair(hand2Simp,[0],[],false),1), [],[],false) == false -> 
        #     _hand1Rank = 1
        # end

        # royalFlush(hand1Simp,0,flush(hand1Simp, "", true),true)

        onePairTieBreak(onePair(hand1Simp,[0],[],false),onePair(hand2Simp,[0],[],false),0)

        # suitCompare([[1,"D"],[2,"C"]],[[1,"D"],[2,"D"]],0)

    end

    def onePairTieBreak(hand1, hand2, winner)do
        cond do
            winner == 0 ->
                cond do
                    hd(hand1) == true && hd(hand2) == false ->  
                        onePairTieBreak(hand1, hand2, 1)

                    hd(hand1) == false && hd(hand2) == true ->
                        onePairTieBreak(hand1, hand2, 2)

                    true -> #if they are both pairs
                        cond do
                            hd(hd(tl(hand1))) > hd(hd(tl(hand2))) && hd(hd(tl(hand2))) != 1 || hd(hd(tl(hand2))) > hd(hd(tl(hand1))) && hd(hd(tl(hand1))) == 1 -> 
                                onePairTieBreak(hand1, hand2, 1)
                            
                            hd(hd(tl(hand2))) > hd(hd(tl(hand1))) && hd(hd(tl(hand1))) != 1 || hd(hd(tl(hand1))) > hd(hd(tl(hand2))) && hd(hd(tl(hand2))) == 1 -> 
                                onePairTieBreak(hand1, hand2, 2)

                            hd(hd(tl(hand1))) == hd(hd(tl(hand2))) ->
                                cond do
                                    highCard(hd(tl(tl(hand1))),0) > highCard(hd(tl(tl(hand2))),0) ->
                                        onePairTieBreak(hand1, hand2, 1)

                                    highCard(hd(tl(tl(hand1))),0) < highCard(hd(tl(tl(hand2))),0) ->
                                        onePairTieBreak(hand1, hand2, 2)

                                    highCard(hd(tl(tl(hand1))),0) == highCard(hd(tl(tl(hand2))),0) -> #TIEEEEEEEEE BREAKKKKK WITH SUITS
                                        cond do
                                            suitCompare(hd(tl(tl(hand1))), hd(tl(tl(hand2))), 0) == 1 ->
                                                onePairTieBreak(hand1, hand2, 1)
                                            suitCompare(hd(tl(tl(hand1))), hd(tl(tl(hand2))), 0) == 2 ->
                                                onePairTieBreak(hand1, hand2, 2)
                                            suitCompare(hd(tl(tl(hand1))), hd(tl(tl(hand2))), 0) == 3 ->
                                                IO.puts "The hands are the EXACT same"
                                        end
                                end 
                        end 
                end
                    
            true ->
                winner

        end
        
    end

    def getHand1(hand,hand1,handLen) do #makes a hand from the given 10 cards
        cond do
        handLen >= 1 ->
            cond do
                rem(handLen, 2) == 0 ->
                    hand1 = hand1 ++ [hd(hand)] #use hd(hand)
                    getHand1(tl(hand),hand1,length(tl(hand)))
                rem(handLen, 2) == 1 ->  
                    getHand1(tl(hand),hand1,length(tl(hand))) 
            end
        handLen < 1 ->
            hand1
        end
    end

    def getHand2(hand,hand2,handLen) do #makes a hand from the given 10 cards
        cond do
        handLen >= 1 ->
            cond do
                rem(handLen, 2) == 1 ->
                    hand2 = hand2 ++ [hd(hand)]
                    getHand2(tl(hand),hand2,length(tl(hand)))
                rem(handLen, 2) == 0 ->  
                    getHand2(tl(hand),hand2,length(tl(hand))) 
            end
        handLen < 1 ->
            hand2
        end
    end

    def simplifyCard(num,count) do #simplifies cards to form [num,suit]
        suits = %{0 => 'C', 1 => 'D', 2 => 'H', 3 => 'S'}
        cond do 
            num > 13 ->
                simplifyCard(num - 13,count+1)
            num <= 13 -> 
                # Integer.to_charlist(num) ++ suits[count]
                [num] ++ [suits[count]]
        end
    end

    def simplifyCardNum(num,count) do #simplifies cards to form [num,suit]
        cond do 
            num > 13 ->
                simplifyCardNum(num - 13,count+1)
            num <= 13 -> 
                num
        end
    end

    def simplifyHandByNum(hand,handSimplified)do #simplifies hand using simplifyCard()
        cond do
            length(hand) >= 1 -> 
                [head | tail] = hand 
                card = simplifyCardNum(head,0)
                handSimplified = handSimplified ++ [card] 
                simplifyHandByNum(tail,handSimplified)
            length(hand) < 1 ->
                Enum.sort(handSimplified)
        end
    end
        
    def simplifyHand(hand,handSimplified)do #simplifies hand using simplifyCard()
        cond do
            length(hand) >= 1 -> 
                [head | tail] = hand 
                card = simplifyCard(head,0)
                handSimplified = handSimplified ++ [card] 
                simplifyHand(tail,handSimplified)
            length(hand) < 1 ->
                Enum.sort(handSimplified)
        end
    end

    def mapHand(hand,mappedHand) do #FIXED MAPPING
        # hand = simplifyHandByNum(hand,[])
        
        cond do
            length(hand) == 5 ->
                mappedHand = Map.merge(mappedHand, %{hd(hd(hand)) => 1})
                mapHand(tl(hand),mappedHand)

            length(hand) >= 1 && length(hand) < 5->
                cond do
                    Map.has_key?(mappedHand,hd(hd(hand))) ->
                        mappedHand = Map.put(mappedHand,hd(hd(hand)), Map.get(mappedHand,hd(hd(hand))) + 1) #if key in map then increment value of key by 1
                        mapHand(tl(hand),mappedHand)

                    true ->
                        mappedHand = Map.merge(mappedHand, %{hd(hd(hand)) => 1})
                        mapHand(tl(hand),mappedHand)
                end
            true ->
                mappedHand
        end    
    end

    def royalFlush(hand,lastNum,flush,isRoyalFlush)do
        
            
            cond do
                
                length(hand) == 5 ->
                    if hd(hd(hand)) != 1 do
                        royalFlush(tl(hand),lastNum,flush,false)
                    else
                        royalFlush(tl(hand),hd(hd(hand)),flush,true)
                    end

                length(hand) == 4 ->
                    if hd(hd(hand)) != 10 do
                        royalFlush(tl(hand),lastNum,flush,false)
                    else
                        royalFlush(tl(hand),hd(hd(hand)),flush,true)
                    end

                length(hand) < 4 && length(hand) >= 1 ->
                    if hd(hd(hand)) == lastNum+1 do
                        royalFlush(tl(hand),hd(hd(hand)),flush,true)
                    else
                        royalFlush(tl(hand),lastNum,flush,false)
                    end

                true ->
                    isRoyalFlush
            end

        if isRoyalFlush == true && flush == true do
            isRoyalFlush = true
        else
            isRoyalFlush = false
        end
    end

    def straightFlush(hand,lastSuit,lastNum,isStraightFlush)do #FIXED MAPPING

        cond do
            length(hand) == 5 ->
                straightFlush(tl(hand),tl(hd(hand)),hd(hd(hand)),true)

            length(hand) < 5 && length(hand) >= 1 ->
                IO.inspect lastNum
                if tl(hd(hand)) == lastSuit && hd(hd(hand)) == lastNum+1 do
                    if isStraightFlush == false do
                        straightFlush(tl(hand),lastSuit,lastNum,false)
                    else
                        straightFlush(tl(hand),lastSuit,hd(hd(hand)),true)
                    end
                else
                    straightFlush(tl(hand),tl(hd(hand)),lastNum,false)
                end
            true ->
                isStraightFlush
        end
        
    end

    def fourPair(hand,highPair,nonPair,isPair) do #FIXED MAPPING
        mappedHand = mapHand(hand,%{})
        # hand1 = simplifyHand(hand,[])
        # hand = simplifyHandByNum(hand,[])

        cond do
            length(hand) >= 1 ->

                cond do
                    Map.get(mappedHand,hd(hd(hand))) == 4 -> #if there is pair
                    
                        cond do

                            hd(hd(hand)) == 1 ->
                                fourPair(tl(hand),hd(hand),nonPair,true)

                            hd(hd(hand)) > hd(highPair) && hd(highPair) != 1 ->
                                if hd(highPair) == 0 do
                                    fourPair(tl(hand),hd(hand),nonPair,true)
                                else
                                    nonPair = nonPair ++ highPair
                                    fourPair(tl(hand),hd(hand),nonPair,true)
                                end
                                

                            true ->
                                fourPair(tl(hand),highPair,nonPair,true)
                        end 
                    
                    true ->
                        if hd(hd(hand)) != hd(highPair) do
                            nonPair = nonPair ++ hd(hand)
                            if isPair == true do 
                                fourPair(tl(hand),highPair,nonPair,true)
                            else 
                                fourPair(tl(hand),highPair,nonPair,false)
                            end
                            
                        else
                            if isPair == true do 
                                fourPair(tl(hand),highPair,nonPair,true)
                            else 
                                fourPair(tl(hand),highPair,nonPair,false)
                            end
                        end
                end
            length(hand) < 1 ->
                [highPair, isPair, nonPair ]

        end
    end

    def fullHouse(twoOfKind, threeOfKind, threePair, onePair, isFullHouse) do
        if twoOfKind == true && threeOfKind == true do
            _isFullHouse = true
        else
            isFullHouse
        end
    end

    def flush(hand, lastSuit, isFlush)do
        cond do
            length(hand) == 5 ->    
                flush(tl(hand), tl(hd(hand)), true)

            length(hand) < 5 && length(hand) >= 1 ->
                if tl(hd(hand)) == lastSuit do
                    flush(tl(hand), lastSuit, true)
                else
                    flush(tl(hand), lastSuit, false)
                end

            true ->
                isFlush
        
        end
    end

    def straight(hand,lowestNum,isStraight)do #FIXED MAPPING
        # hand = simplifyHandByNum(hand,[])
        cond do 
            length(hand) == 5 ->
                straight(tl(hand),hd(hd(hand)),true)

            length(hand) < 5 && length(hand) >= 1 ->
                IO.inspect hd(hd(hand))
                if hd(hd(hand)) == (lowestNum + 1) do
                    if isStraight == true do
                        straight(tl(hand),hd(hd(hand)),true)
                    else
                        straight(tl(hand),hd(hd(hand)),false)
                    end
                    
                else
                    straight(tl(hand),lowestNum,false)
                end

            true ->
                isStraight

        end

    end

    def threePair(hand,highPair,nonPair,isPair) do #FIXED MAPPING
        mappedHand = mapHand(hand,%{})
        # hand1 = simplifyHand(hand,[])
        # hand = simplifyHandByNum(hand,[])

        cond do
            length(hand) >= 1 ->

                cond do
                    Map.get(mappedHand,hd(hd(hand))) == 3 -> #if there is pair
                    
                        cond do

                            hd(hd(hand)) == 1 ->
                                threePair(tl(hand),hd(hand),nonPair,true)

                            hd(hd(hand)) > hd(highPair) && hd(highPair) != 1 ->
                                if hd(highPair) == 0 do
                                    threePair(tl(hand),hd(hand),nonPair,true)
                                else
                                    nonPair = nonPair ++ [highPair]
                                    threePair(tl(hand),hd(hand),nonPair,true)
                                end
                                

                            true ->
                                threePair(tl(hand),highPair,nonPair,true)
                        end 
                    
                    true ->
                        if hd(hd(hand)) != hd(highPair) do
                            nonPair = nonPair ++ [hd(hand)]
                            if isPair == true do 
                                threePair(tl(hand),highPair,nonPair,true)
                            else 
                                threePair(tl(hand),highPair,nonPair,false)
                            end
                            
                        else
                            if isPair == true do 
                                threePair(tl(hand),highPair,nonPair,true)
                            else 
                                threePair(tl(hand),highPair,nonPair,false)
                            end
                        end
                end
            length(hand) < 1 ->
                [highPair, isPair, nonPair ]

        end
    end

    def twoPair(hand,pairArr,nonPair,prevPair,isTwoPair)do #FIXED MAPPING
        mappedHand = mapHand(hand,%{})
        # hand1 = simplifyHand(hand,[])
        # hand = simplifyHandByNum(hand,[])

        cond do
            length(hand) >= 1 ->
                cond do

                    Map.get(mappedHand,hd(hd(hand))) == 2 ->
                        prevPair = prevPair ++ [hd(hd(hand))]
                        pairArr = pairArr ++ [hd(hand)]
                        if length(pairArr) < 2 do
                            twoPair(tl(hand),pairArr,nonPair,prevPair,false)
                        else
                            twoPair(tl(hand),pairArr,nonPair,prevPair,true)
                        end

                    true ->
                        if isTwoPair == true do
                            if Enum.find(prevPair, fn x -> x == hd(hd(hand)) end) != nil do
                                twoPair(tl(hand),pairArr,nonPair,prevPair,true)
                            else
                                twoPair(tl(hand),pairArr,hd(hd(hand)),prevPair,true)
                            end
                            
                        else
                            if Enum.find(prevPair, fn x -> x == hd(hd(hand)) end) != nil do
                                twoPair(tl(hand),pairArr,nonPair,prevPair,false)
                            else
                                twoPair(tl(hand),pairArr,hd(hd(hand)),prevPair,false)
                            end
                            
                        end
                end

            length(hand) < 1 ->
                [pairArr, isTwoPair]
        end
    end

    def onePair(hand,highPair,nonPair,isPair) do #FIXED MAPPING
        mappedHand = mapHand(hand,%{})
        # hand1 = simplifyHand(hand,[])
        # hand = simplifyHandByNum(hand,[])

        cond do
            length(hand) >= 1 ->
                cond do

                    Map.get(mappedHand,hd(hd(hand))) == 2 -> #if there is pai
                        cond do

                            hd(hd(hand)) == 1 ->
                                onePair(tl(hand),hd(hand),nonPair,true)

                            hd(hd(hand)) > hd(highPair) && hd(highPair) != 1 ->
                                if hd(highPair) == 0 do
                                    onePair(tl(hand),hd(hand),nonPair,true)
                                else
                                    nonPair = nonPair ++ [highPair]
                                    onePair(tl(hand),hd(hand),nonPair,true)
                                end

                            true ->
                                onePair(tl(hand),highPair,nonPair,true)
                        end 
                    
                    true ->
                        if hd(hd(hand)) != hd(highPair) do
                            nonPair = nonPair ++ [hd(hand)]
                            if isPair == true do 
                                onePair(tl(hand),highPair,nonPair,true)
                            else 
                                onePair(tl(hand),highPair,nonPair,false)
                            end
                            
                        else
                            if isPair == true do 
                                onePair(tl(hand),highPair,nonPair,true)
                            else 
                                onePair(tl(hand),highPair,nonPair,false)
                            end
                        end
                end
            length(hand) < 1 ->
                [isPair, highPair, nonPair ]
        end
    end

    def highCard(hand,highNum)do
        cond do
            length(hand) <= 5 && length(hand) >= 1 ->
                cond do 
                    (hd(hd(hand)) > highNum) && (highNum != 1) ->
                        highCard(tl(hand),hd(hd(hand)))

                    (hd(hd(hand)) > highNum) && (highNum == 1) ->
                        highCard(tl(hand),highNum)

                    true ->
                        highCard(tl(hand),highNum)
                end
                               
            true ->
                highNum
        end
        
    end

    def suitCompare(card1, card2, winner)do
        suitDict = %{"S" => 4, "H" => 3, "D" => 2, "C" => 1}
        cond do
            length(card1) != 0 ->
                cond do
                    Map.get(suitDict,hd(tl(hd(card1)))) > Map.get(suitDict,hd(tl(hd(card2)))) ->
                        suitCompare(tl(card1), tl(card2), 1)

                    Map.get(suitDict,hd(tl(hd(card1)))) < Map.get(suitDict,hd(tl(hd(card2)))) ->
                        suitCompare(tl(card1), tl(card2), 2)

                    true ->
                        suitCompare(tl(card1), tl(card2), 3)
                end
            true ->
                winner
        end
        
        
    end

end



# IO.inspect Poker.mapHand([1,49,27,12,14],%{})

# Poker.deal[1,1,2,2,3,3,4,4,5,5]

# IO.inspect Poker.deal([1,14,10,22,11,40,12,45,13,50])

# IO.inspect Poker.threePair([1,49,27,12,14],[0],[],false)

# IO.inspect Poker.onePair([1,49,27,12,14],[0],[],false)

# IO.inspect Poker.fullHouse([10,49,27,12,23],0,[],false) 











    
