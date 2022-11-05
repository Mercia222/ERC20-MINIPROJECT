// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//import the interface
import "./interfaceT4D.sol"; 

//opening the main contract and inheriting the interface to it 
contract mainERC20 is IERC20T4D{

//declare totalSupply as a state variable and specify the override keyword in order to avoid conflict with the interface
    uint public override totalSupply; 

//to track the balance, declaring a mapping with address as key and uint as value in order to map the address of the account and the amount
    mapping(address => uint) public override balanceOf; 

/* the owner allows the spender, nested mapping, first mapping takes the address of the owner 
* second mapping captures the address of the recipient and the amount */ 
    mapping(address => mapping(address => uint)) public override allowance;

/*defining what exactly is transferred, declaring the name, symbol and decimals of the token 
* visibility specifier is public in order to make it accessible to other contracts*/
    string public name = "Tech4dev Token"; 
    string public symbol = "T4D"; 
    uint public decimals = 18; 

//deducting and moving the amount from caller's account to the recipient's account  
    function transfer(address recipient, uint amount) external override returns(bool){
balanceOf[msg.sender] -= amount;  //accesssing msg.sender's address, method 1 is deducting the amount from sender's balance
balanceOf[recipient] += amount; //accessing recipient's address, method 2 is adding amount to recipient's balance 

//emitting a Transfer event, amount transferred from msg.sender to the recipient
emit Transfer(msg.sender, recipient, amount); 
return true; //returns a boolean value that specifies if the operation succeded

}

/*declaring function approve, owner gives approved amount to recipient 
* it sets the amount as allowance of spender over the caller's wallet*/   
    function approve(address spender, uint amount) external override returns(bool){
allowance[msg.sender][spender] = amount; //according to our mapping the order is: owner is allowing spender to spend amount 

emit Approval(msg.sender, spender, amount); //emitting an Approval event to confirm the approval
return true; //returns a boolean value that specifies if the operation was successful

    }

//declaring function TransferFrom, it moves the amount from sender to recipient using allowance
    function transferFrom(address sender, address recipient, uint amount) external override returns(bool){
//recipient is the caller, we need the allowance mechanism to check if he has enough approval, amount has to be first deducted from the allowance
allowance[sender][msg.sender] -= amount; 
balanceOf[sender] -= amount; //balance of the sender, the amount is deducted from the sender's account 
balanceOf[recipient] += amount; //balance of the recipient should increase since amount is added to recipient's account 

emit Transfer(sender, recipient, amount); //making it happen by emitting a transfer event with the amount from the sender to the recipient 
return true; //returns a boolean value that confirms if the operation succeded 

}
//declaring mint function that creates more amount of tokens and assigns them to account, which increases the total supply, it takes the inputed amount
function mint(uint amount) public{
    balanceOf[msg.sender] += amount; //adds inputed amount to the owner's balance
    totalSupply += amount; //total supply is increased by the amount inputed 

    emit Transfer(address(0), msg.sender, amount);//emits a Transfer event from address zero to the person calling the contract(msg.sender) 
}

/*declaring burn function that destroys the amount of tokens from the msg.sender account and to the address zero, 
which reduces the total supply, it takes an inputed amount */
function burn(uint amount) public{
    balanceOf[msg.sender] -= amount;//amount is deducted from the person calling the contract (msg.sender)
    totalSupply -= amount;//deducting the amount from the totalSupply

    emit Transfer(msg.sender, address(0), amount);//emits a transfer event from the msg.sender to the zero address
    
}

}