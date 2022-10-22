import axios from "axios";

const remote = axios.create();
const defaultURL = "https://pokeapi.co/api/v2/pokemon/";

export interface PokemonListResponseType {
  count: number;
  next: string;
  results: {
    name: string;
    url: string;
  }[];
}

export async function fetchPokemons() {
  const response = await remote.get<PokemonListResponseType>(defaultURL);
  return response.data;
}
