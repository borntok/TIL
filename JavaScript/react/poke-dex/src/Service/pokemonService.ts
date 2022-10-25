import axios from "axios";

const remote = axios.create();

export interface PokemonListResponseType {
  count: number;
  next: string;
  results: {
    name: string;
    url: string;
  }[];
}

export async function fetchPokemonsAPI(nextURL?: string) {
  const requestURL = nextURL ? nextURL : "https://pokeapi.co/api/v2/pokemon/";
  const response = await remote.get<PokemonListResponseType>(requestURL);
  return response.data;
}

interface PokemonDetailResponseType {
  id: number;
  weight: number;
  height: number;
  name: string;
  types: {
    type: {
      name: string;
    };
  }[];
  sprites: {
    front_default: string;
    other: {
      dream_world: {
        front_default: string;
      };
      "official-artwork": {
        front_default: string;
      };
    };
  };
  stats: {
    base_stat: number;
    stat: {
      name: string;
    };
  }[];
}

interface PokemonSpeciesResponseType {
  color: {
    name: string;
  };
  names: {
    name: string;
    language: {
      name: string;
    };
  }[];
}

export interface PokemonDetailType {
  id: number;
  weight: number;
  height: number;
  name: string;
  koreanName: string;
  color: string;
  types: string[];
  images: {
    frontDefault: string;
    dreamWorldFront: string;
    officialArtworkFront: string;
  };
  baseStats: {
    name: string;
    value: number;
  }[];
}

export async function fetchPokemonDetail(
  name: string
): Promise<PokemonDetailType> {
  const pokemonDetailURL = `https://pokeapi.co/api/v2/pokemon/${name}`;
  const pokemonSpeciesURL = `https://pokeapi.co/api/v2/pokemon-species/${name}`;

  const response = await remote.get<PokemonDetailResponseType>(
    pokemonDetailURL
  );
  const speciesResponse = await remote.get<PokemonSpeciesResponseType>(
    pokemonSpeciesURL
  );

  return {
    id: response.data.id,
    name: response.data.name,
    koreanName:
      speciesResponse.data.names.find((item) => item.language.name === "ko")
        ?.name ?? response.data.name,
    color: speciesResponse.data.color.name,
    weight: response.data.weight / 10,
    height: response.data.height / 10,
    types: response.data.types.map((item) => item.type.name),
    images: {
      frontDefault: response.data.sprites.front_default,
      dreamWorldFront: response.data.sprites.other.dream_world.front_default,
      officialArtworkFront:
        response.data.sprites.other["official-artwork"].front_default,
    },
    baseStats: response.data.stats.map((item) => {
      return { name: item.stat.name, value: item.base_stat };
    }),
  };
}
