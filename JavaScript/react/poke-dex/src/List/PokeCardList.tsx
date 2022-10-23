import styled from "@emotion/styled";
import { useEffect, useState } from "react";
import useInfiniteScroll from "react-infinite-scroll-hook";
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

  const [infiniteRef] = useInfiniteScroll({
    loading: false,
    hasNextPage: pokemons.next !== "",
    onLoadMore: async () => {
      const morePokemons = await fetchPokemons(pokemons.next);
      setPokemons({
        ...morePokemons,
        results: [...pokemons.results, ...morePokemons.results],
      });
    },
    disabled: false,
    rootMargin: "0px 0px 400px 0px",
  });

  useEffect(() => {
    (async () => {
      const pokemons = await fetchPokemons();
      setPokemons(pokemons);
    })();
  }, []);

  return (
    <>
      <List>
        {pokemons.results.map((pokemon) => {
          return <PokeCard key={pokemon.name} name={pokemon.name} />;
        })}
      </List>
      <Loading ref={infiniteRef}>Loading..</Loading>
    </>
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

const Loading = styled.div`
  display: flex;
  justify-content: center;
`;
