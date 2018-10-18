pragma solidity ^0.4.24;

contract HashStorage {

    address private controller;
    string private creater;
    uint counter;
    
    struct DataObject {
        string original_message;
        string hashData_1;
        string hashData_2;
        string editor_id;
        address editor_addresss;
    }
    
    mapping (uint => DataObject) dataObject;
    
    function HashStorage(string _original_message, string _hashData1, string _hashData2, string _creater) {
        controller = msg.sender;
        creater = _creater;
        counter = 0;
        dataObject[counter].original_message = _original_message;
        dataObject[counter].hashData_1 =_hashData1;
        dataObject[counter].hashData_2 =_hashData2;
        dataObject[counter].editor_id =_creater;
        dataObject[counter].editor_addresss = msg.sender;
    }
    
    function updateDataObject(string _original_message, string _lastHash1, string _lastHash2, string _newHash1, string _newHash2, string _editor) public {
        require(
            compareStrings(_lastHash1, dataObject[counter].hashData_1)
        &&  compareStrings(_lastHash2, dataObject[counter].hashData_2)
        );
        dataObject[counter + 1].original_message = _original_message;
        dataObject[counter + 1].hashData_1 = _newHash1;
        dataObject[counter + 1].hashData_2 = _newHash2;
        dataObject[counter + 1].editor_id = _editor;
        dataObject[counter + 1].editor_addresss = msg.sender;

        counter++;
    }
    
    function getDataObject(uint _index) public view returns (string, string, string, string, address){
        return (
                dataObject[_index].original_message,
                dataObject[_index].hashData_1,
                dataObject[_index].hashData_2,
                dataObject[_index].editor_id,
                dataObject[_index].editor_addresss
                );
    }
    
    function lastDataObject() public view returns (string, string, string, string, address){
        return (
                dataObject[counter].original_message,
                dataObject[counter].hashData_1,
                dataObject[counter].hashData_2,
                dataObject[counter].editor_id,
                dataObject[counter].editor_addresss
                );
    }
    
    function compareStrings (string a, string b) internal returns (bool){
       return keccak256(a) == keccak256(b);
    }
}
