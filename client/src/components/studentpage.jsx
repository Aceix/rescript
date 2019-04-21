import React,{Component} from "react";
import "./studentpage.css";
import {NavLink} from "react-router-dom";
import SimpleStorageContract from "../contracts/SimpleStorage.json";
import getWeb3 from "../utils/getWeb3";
import firebase from 'firebase'


export default class StudentPage extends Component{
    constructor(props){
        super(props)
        this.state = {imgUrl: ""}
        this.requestDownload = this.requestDownload.bind(this)
    }
    
    requestDownload(){
        let self = this
        let storageRef = firebase.storage().ref().child('transcripts').child('tra.jpg')
        storageRef.getDownloadURL().then((url) => {
            self.setState({
                imgUrl: url
            })
            this.updateView()
        })
    }

    updateView(){
        let ap = document.getElementById('attach-point')
        let i = document.createElement('img')
        i.src = this.state.imgUrl
        let s = document.createElement('select')
        let t = document.createElement('option')
        t.text = 'MIT'
        s.appendChild(t)
        t = document.createElement('option')
        t.text = 'Univ. of Ghana'
        s.appendChild(t)
        t = document.createElement('option')
        t.text = 'KNUST'
        s.appendChild(t)
        t = document.createElement('option')
        t.text = 'UDS'
        s.appendChild(t)

        let al = document.createElement('div')
        al.appendChild(document.createTextNode('Forward to school'))
        al.appendChild(s)

        let sBtn = document.createElement('button')
        sBtn.innerText = 'Forward'
        sBtn.classList.add('button3')
        sBtn.style.height = '30px'
        sBtn.style.width = '100px'
        sBtn.onclick = () => {
            setTimeout(() => {
                sBtn.innerText = 'SENT!'
                // al.appendChild(document.createTextNode('SENT!!'))
            }, 1500);
        }
        al.appendChild(sBtn)

        ap.appendChild(i)
        ap.appendChild(al)
    }

    render(){
        return(
            <div className="sp-body">
                <div id="header4">
                    <span className="rescript">Rescript</span>
                    <span className="dashboard">Student Dashboard</span>
                    <NavLink to="/"><span className="logout">Log out</span></NavLink>
                </div>

                <div id="body-body">
                    <span>
                        <p>Name: </p>
                        <p>Oppong Paa Kwasi</p>
                    </span>
                    <span>
                        <p>Reference: </p>
                        <p>20112786675</p>
                    </span>
                    <span>
                        <p>Previous Institution:</p>
                        <p>kwame Nkrumah University of Science and Technology</p>
                        <NavLink to="#">
                            <div className="button3" onClick={this.requestDownload} id="m-button">
                                    Request
                            </div>
                        </NavLink>
                    </span>
                    <div className="transcript" id="attach-point">
                        {/* <img src={this.state.imgUrl} alt=""/>
                        <div>
                            Forward to school
                            <select>
                                <option name="" id="">University of Development Studies</option>
                                <option name="" id="">MIT</option>
                                <option name="" id="">University of Ghana, Legon</option>
                                <option name="" id="">KNUST</option>
                            </select>
                            <button>SEND</button>
                        </div> */}
                    </div>
                </div>
            </div>
        );
    }
}