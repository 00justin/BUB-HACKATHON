// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract NeighborhoodToken is ERC20 
{
    string public tokenName = "NeighborhoodToken";
    string public tokenSymbol = "NBRHD";
    
    address public owner;
    
    string[] public proposals;  //lists for proposals and votes
    uint[] public votesFor;   
    uint[] public votesAgainst;
    
    constructor() ERC20("NeighborhoodToken", "NBRHD") 
    {
        owner = msg.sender;
        _mint(msg.sender, 10000 * 10**18);  
    }
    
    function sendTokens(address to, uint amount) public 
    {
        _transfer(owner, to, amount);
    }
    
    //people can make proposal
    function createProposal(string memory description) public 
    {
        proposals.push(description);
        votesFor.push(0);
        votesAgainst.push(0);
    }
    
    // vote function
    function vote(uint proposalId, bool support) public 
    {

        if (support) 
        {
            votesFor[proposalId] += 1;
        } 
        else 
        {
            votesAgainst[proposalId] += 1;
        }
    }
    
    // check num of proposals
    function getProposalCount() public view returns (uint) 
    {
        return proposals.length;
    }
    
    // return proposal details
    function getProposal(uint id) public view returns (string memory, uint, uint) 
    {
        return (proposals[id], votesFor[id], votesAgainst[id]);
    }
}