import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { IPokemon } from './models/pokemon';

@Injectable({
  providedIn: 'root'
})
export class AjaxService {

  constructor(private myHttpCli: HttpClient) { }

  obtainPokemon(): Observable<string>{
    return this.myHttpCli.get<string>('https://pokeapi.co/api/v2/pokemon/starmie');
  }

  obtainPokemonDynamically(pokeName: string): Observable<string>{
    return this.myHttpCli.get<string>('https://pokeapi.co/api/v2/pokemon/' + pokeName);
  }

  obtainPokemonDynamicallyUsingInterface(pokeName: string): Observable<IPokemon>{
    return this.myHttpCli.get<IPokemon>('https://pokeapi.co/api/v2/pokemon/' + pokeName);
  }
}
