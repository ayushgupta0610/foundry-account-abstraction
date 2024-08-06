// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {MinimalAccount} from "./MinimalAccount.sol";

contract MinimalAccountFactory {
    address private constant ENTRY_POINT = 0x0000000071727De22E5E9d8BAf0edAc6f37da032;

    mapping(address => address) public accountAddresses;

    event AccountCreated(address indexed owner, address indexed account);

    function createAccount(address owner) external returns (address) {
        require(accountAddresses[owner] == address(0), "Account already exists");

        bytes32 salt = keccak256(abi.encodePacked(owner));
        address account = address(new MinimalAccount{salt: salt}(ENTRY_POINT, owner));

        accountAddresses[owner] = account;
        emit AccountCreated(owner, account);

        return account;
    }

    function getAccountAddress(address owner) public view returns (address) {
        bytes32 salt = keccak256(abi.encodePacked(owner));
        bytes memory creationCode = type(MinimalAccount).creationCode;
        bytes memory bytecode = abi.encodePacked(creationCode, abi.encode(ENTRY_POINT, owner));
        bytes32 hash = keccak256(abi.encodePacked(bytes1(0xff), address(this), salt, keccak256(bytecode)));
        return address(uint160(uint256(hash)));
    }

}
