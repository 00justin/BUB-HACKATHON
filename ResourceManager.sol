// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ResourceManager 
{
    ERC20 public token;
    address public owner;
    
    string[] public resourceNames;  // names of resource
    uint[] public resourcePrices;   // prices in order
    bool[] public resourceAvailable; //list of true and false in order
    
    address[] public reservations;  // reservations[resourceId] = who reserved it
    
    constructor(address tokenAddress) 
    {
        owner = msg.sender;
        token = ERC20(tokenAddress);
        
        resourceNames.push("Picnic Area"); //examples 
        resourcePrices.push(10);
        resourceAvailable.push(true);
        reservations.push(address(0));
        resourceNames.push("Garden");
        resourcePrices.push(5);
        resourceAvailable.push(true);
        reservations.push(address(0));
    }
    

    function bookResource(uint resourceId) public 
    {
        token.transferFrom(msg.sender, address(this), resourcePrices[resourceId]);
        resourceAvailable[resourceId] = false;
        reservations[resourceId] = msg.sender;
    }
    
    function returnResource(uint resourceId) public 
    {
        resourceAvailable[resourceId] = true;
        reservations[resourceId] = address(0);
    }

    function getResourceCount() public view returns (uint) 
    {
        return resourceNames.length;
    }
    
    // get resource details
    function getResource(uint id) public view returns (string memory, uint, bool, address) 
    {
        return (resourceNames[id], resourcePrices[id], resourceAvailable[id], reservations[id]);
    }
    
    // add resource 
    function addResource(string memory name, uint price) public 
    {
        resourceNames.push(name);
        resourcePrices.push(price);
        resourceAvailable.push(true);
        reservations.push(address(0));
    }
}