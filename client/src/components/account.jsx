import React, {Component} from "react";
import "./account.css"
import {NavLink} from "react-router-dom";
import firebase from 'firebase'


export default class Account extends Component{
    constructor(){
        super()
        this.state = {btnText: "Upload Transcript"}

        this.uploadFile = this.uploadFile.bind(this)
    }

    uploadFile(){
        let file = document.getElementById('file-upload')
        let fr = new FileReader()
        fr.onload = ((theFile) => {
            let storageRef = firebase.storage().ref().child('transcripts').child('tra.jpg')
            storageRef.put(fr.result).then((snap) => {
                this.setState({btnText: 'UPLOADED'})
                console.log('uploaded');
            })
        })
        fr.readAsArrayBuffer(file.files[0])
    }


    render(){
        return(
            <div className="body1">
                <div id="header4">
                    <span className="rescript"></span>
                    <span className="dashboard"></span>
                    <NavLink to="/"><span className="logout"></span></NavLink>
                </div>
                <div id="body-body1">
                    <span>
                        <p>Name: </p>
                        <p>Oppong Paa Kwasi</p>
                    </span>
                    <span>
                        <p>Reference: </p>
                        <p>20112786675</p>
                    </span>
                    <span>
                        <p>Year Completed: </p>
                        <p>2019</p>
                    </span>
                    <input type="file" name="file-upload" id="file-upload"/>
                    <NavLink to="#">
                        <div className="button5" onClick={this.uploadFile}>
                            {this.state.btnText}
                        </div>
                    </NavLink>
                </div>
            </div>
        );
    }
}