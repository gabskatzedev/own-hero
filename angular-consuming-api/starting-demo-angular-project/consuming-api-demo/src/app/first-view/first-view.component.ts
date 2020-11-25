import { Component, OnInit } from '@angular/core';
import { AjaxService } from '../ajax.service';
import { IPokemon } from '../models/pokemon';

@Component({
  selector: 'app-first-view',
  templateUrl: './first-view.component.html',
  styleUrls: ['./first-view.component.css']
})
export class FirstViewComponent implements OnInit {

  jsonDisplay: string = null;
  inputField = '';
  inputField2 = '';
  pokemonInterfaceDisplay: IPokemon = null;

  constructor(private myAjax: AjaxService) { }

  ngOnInit(): void {
  }

  firstButton(): void {
     console.log("button clicked");
    this.myAjax.obtainPokemonDynamically(this.inputField).subscribe(
      //callback fx
      data => {
        this.jsonDisplay = data;
         console.log(data);
      }
    );
  }

  secondButton(): void {
     console.log("button clicked");
    this.myAjax.obtainPokemonDynamicallyUsingInterface(this.inputField2).subscribe(
      //callback fx
      data => {
        this.pokemonInterfaceDisplay = data;
        console.log(data);
      }
    );
  }
}
