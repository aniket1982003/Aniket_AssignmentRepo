    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0;

    contract Lottery
     {
        uint[8][] lottery;
        uint private seed ;
        uint[8] private winner ;
        constructor()
        {
            seed = block.timestamp;
            winner=[0,3,0,9,2,0,0,3];
        }

        function randomBetween0And9() private returns (uint) 
        {
            seed+=1;
            return uint256(keccak256(abi.encodePacked(seed))) % 10;
        }
      
        function DrawLottry(uint id) public returns (uint[8] memory)
        {
            require(id-1<lottery.length,"Invalid Id");
           
            for (uint i=0;i<8;i++)
            {
                lottery[id-1][i] = randomBetween0And9();
            }
               return lottery[id-1];
        }
     
        function NewCustomer()public returns(uint ,uint[8] memory)
        {
            uint[8] memory temp ;
            for (uint i=0; i<8; i++)
            {
                temp[i] = randomBetween0And9();
            }

            lottery.push(temp);
                   return (lottery.length,temp);
        }
    

        function CheckLottey(uint id) public returns(string memory) 
        {
            require(id-1<lottery.length,"Invalid Id");
               for (uint i=0; i<8; i++) 
               {
                     require(lottery[id-1][i] == winner[i],"Batter Luck next time");
               }
               for (uint i=0; i<8; i++) 
               {
                     winner[i] = randomBetween0And9();
               }
            return "Winner 7 Crore";
        }

    }