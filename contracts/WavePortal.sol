pragma solidity ^0.8.0;

import "hardhat/console.sol";


contract WavePortal {

    uint256 totalWaves;
    uint256 private seed;

    mapping(address => uint256) public lastWavedAt;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;
        uint256 timestamp;
        string message;
    }

    Wave[] waves;

    constructor() payable {
        console.log("lets get going in this web3 yo");
        seed = (block.timestamp + block.number) % 100;
    }

    function wave(string memory _message) public {

        require(lastWavedAt[msg.sender] + 30 seconds < block.timestamp, "You can only wave once every 30 seconds");

        lastWavedAt[msg.sender] = block.timestamp;


        totalWaves++;
        console.log("%s has waved w/message %s", msg.sender, _message);

        waves.push(Wave(msg.sender, block.timestamp, _message));

        seed = (block.timestamp + block.number + seed) % 100;
        console.log("random # generated : %d", seed);

        if (seed <= 50) {
            console.log("%s won!", msg.sender);
            uint256 prizeAmount = 0.0001 ether;

            require(
            prizeAmount <= address(this).balance,
            "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value:prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        
        }

        emit NewWave(msg.sender, block.timestamp, _message);

        

        
        
    }
    
    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("we have %d waves", totalWaves);
        return totalWaves;
    }
}