// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "hardhat/console.sol";

//This is the main building block for smart contracts.
contract Token {

    // Some string type variables to identify the token.
    string public name = "My Very First Hardhat Token";
    string public symbol = "MHT";

    // the fixed amount of tokens, stored in an unsigned integer type variable.
    uint256 public totalSupply = 1000000;

    // An address type variable is used to store ethereum accounts.
    address public owner;

    // A mapping is a key/value map. Here we store each account"s balancce.
    mapping(address => uint256) balances;

    // The Transfer event helps off-chain applications understand
    //that happens within your contract.
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    /**
    * Contract initialization.
    */
    constructor() {

        // The totalSupply is assigned to the transdaction sender , which is the
        // account that is deploying the contract.
        balances[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    /**
     * A function to transfer tokens.
     *
     * The 'external' modifier makes a funcction *only* callable from *outside*
     * the contract.
     */
    function transfer(address to, uint256 amount) external {

        // Check is the transaction sender has enough tokens.
        // If 'require''s first argument avaluates to 'false' then the 
        // transaction will revert.
        require(balances [msg.sender] >= amount, "Not enough tokens");

        console.log(
        "Transferring from %s to %s %s tokens",
        msg.sender,
        to,
        amount
    );
    
        // Transfer the amount.
        balances[msg.sender] -= amount;
        balances[to] += amount;

        // Notify off-chain application of the transfer.
        emit Transfer(msg.sender, to, amount);
    }

    /**
     * Read only function to retrive the token of a given account.
     *
     *The 'view' modifier indicates that it doesn't modify the contarct's
     *state, which allows us to call it without excuting a transaction.
     */
    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    } 
}