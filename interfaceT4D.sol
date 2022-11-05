// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//interface declaration interface keyword + Iinterface name
interface IERC20T4D{
    //functions' visibility specifier is set to external inside an interface
    //function totalSupply to capture the amount of tokens that exist
    function totalSupply() external view returns(uint);

    /*function balanceOf to capture the address of the person requesting for the balance as an input, 
     * to return the balance i.e the amount of tokens in the account */
    function balanceOf(address account) external view returns(uint); 

    //function transfer takes the address of the recipient and the amount to be transferred
    function transfer(address recipient, uint amount) external returns(bool);

    /*function allowance takes in the owner's address and the spender's address, 
    *the owner allows the spender to spend from his wallet
    * returns the number of tokens that spender is allowed to spend*/ 
    function allowance(address owner, address recipient) external view returns(uint); 

    /* function approve gives approval to the recipient to spend, 
     * will take the spender's address and the amount approved*/
    function approve(address spender, uint amount) external returns(bool);

    /*function transferFrom, the spender transfers amount from owner's account according to his allowance
     * can only be called by the person(msg.sender) that is allowed to access the owner's account*/
    function transferFrom(address sender, address recipient, uint amount) external returns(bool); 

/*declare Transfer event to know when the transfer has been called, 
*will take the address where the transfer comes from, address that receives the transfer, and the value
*indexed keyword helps to filter the log to get the wanted data easily */
event Transfer(address indexed from, address indexed to, uint amount); 

/*declare Approval event to know when the Approval has been called; 
 *will take the address where the transfer comes from, address that receives the transfer, 
 and the value
 *indexed keyword helps to filter the log to get the wanted data easily*/ 
event Approval(address indexed owner, address indexed spender, uint amount);

}
