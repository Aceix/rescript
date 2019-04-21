import React, {Component} from "react";
import "./schoolSignUp.css"

export default class SchoolSignUp extends Component {
    render(){
        return(
            <div className="signupMain">
                <div className="innerbody">
                    <div className="title">
                        School Sign Up
                    </div>
            
                    <div className="inputDiv">
                        <input type="text" placeholder="Name of Institution"/>

                        <div className="location">
                            <label htmlFor="iframe">Location</label>
                            <iframe  title="map window" src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d392856.82031805563!2d-1.8130309768400492!3d6.737521115497882!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xfd75acda8dad6c7%3A0x54d7f230d093d236!2sGhana!5e0!3m2!1sen!2sgh!4v1536334197962"frameBorder="0"allowFullScreen></iframe> 
                        </div>

                        <input type="email" placeholder="E-mail address"/>

                        <input type="password" placeholder="Password"/>

                        <input type="text" placeholder="Phone number"/>
                    </div>

                    <div className="button1">Sign Up</div>

                    
                </div>
            </div>
        );
    }
}