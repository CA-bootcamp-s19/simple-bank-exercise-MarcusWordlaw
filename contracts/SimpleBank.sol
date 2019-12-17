/*
    This exercise has been updated to use Solidity version 0.5
    Breaking changes from 0.4 to 0.5 can be found here:
    https://solidity.readthedocs.io/en/v0.5.0/050-breaking-changes.html
*/

pragma solidity ^0.5.0;

contract SimpleBank {

    mapping (address => uint) private balances;
    mapping (address => bool) public enrolled;

    address payable public owner;

    event LogEnrolled(address accountAddress);
    event LogDepositMade(address accountAddress, uint amount);
    event LogWithdrawal(address accountAddress, uint withdrawAmount, uint newBalance);

    constructor() public {
        owner = msg.sender;
    }
    function() external payable {
        revert('error');
    }
    function getBalance() public view returns (uint) {
        return balances[msg.sender];
    }
    function enroll() public returns (bool) {
        enrolled[msg.sender] = true;
        emit LogEnrolled(owner);
    }
    function deposit() public payable returns (uint) {
        require(enrolled[msg.sender], 'A user must be enrolled to deposit');
        balances[msg.sender] += msg.value;
        emit LogDepositMade(msg.sender, balances[msg.sender]);
        return balances[owner];
    }
    function withdraw(uint withdrawAmount) public returns (uint) {
        balances[msg.sender] -= withdrawAmount;
        owner.transfer(withdrawAmount);
        emit LogWithdrawal(msg.sender, withdrawAmount, balances[owner]);
        return balances[owner];
    }

}