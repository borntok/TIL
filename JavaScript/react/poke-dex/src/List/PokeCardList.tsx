import styled from "@emotion/styled";
import { useEffect, useState } from "react";
import {
  fetchPokemons,
  PokemonListResponseType,
} from "../Service/pokemonService";
import PokeCard from "./PokeCard";

export default function PokeCardList() {
  const [pokemons, setPokemons] = useState<PokemonListResponseType>({
    count: 0,
    next: "",
    results: [],
  });

  useEffect(() => {
    (async () => {
      const pokemons = await fetchPokemons();
      setPokemons(pokemons);
    })();
  });

  return (
    <List>
      {pokemons.results.map((pokemon) => {
        return <PokeCard key={pokemon.name} name={pokemon.name} />;
      })}
    </List>
  );
}

const List = styled.ul`
  list-style: none;
  padding: 0;
  margin: 0 0 32px 0;
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: center;
  gap: 20px;
`;
