//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract StellaToken {

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    uint256 private _totalSupply;
    string private _name;
    string private _symbol;
    uint8 private _decimals;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(address owner_, uint256 initialSupply) {
        _name = "StellaToken";
        _symbol = "STO";
        _decimals = 18;
        _totalSupply = initialSupply;
        _balances[owner_] = initialSupply;

        emit Transfer(address(0), owner_, initialSupply);
    }

    function transfer(address recipient, uint256 amount) public returns (bool) {
        require(recipient != address(0), "StellaToken: transfer to the zero address");
        require(_balances[msg.sender] >= amount, "StellaToken: transfer amount exceeds balance");
        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public returns (bool) {
        require(recipient != address(0), "StellaToken: transfer to the zero address");
        require(_balances[sender] >= amount, "StellaToken: transfer amount exceeds balance");
        require(_allowances[sender][msg.sender] >= amount, "StellaToken: transfer amount exceeds allowance");
        _balances[sender] -= amount;
        _balances[recipient] += amount;
        _allowances[sender][msg.sender] -= amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint256 amount) public returns (bool) {
        require(spender != address(0), "StellaToken: approve to the zero address");
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }
}

