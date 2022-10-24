import styled from "@emotion/styled";
import { useEffect, useState } from "react";
import { useIntersectionObserver } from "react-intersection-observer-hook";
import { useSelector } from "react-redux";
import { useNavigate } from "react-router-dom";
import { PokeImageSkeleton } from "../Common/PokeImageSkeleton";
import PokeMarkChip from "../Common/PokeMarkChip";
import PokeNameChip from "../Common/PokeNameChip";
import {
  fetchPokemonDetail,
  PokemonDetailType,
} from "../Service/pokemonService";
import { RootState } from "../Store";

interface PokeCardProps {
  name: string;
}

export default function PokeCard(props: PokeCardProps) {
  const navigate = useNavigate();
  const imageType = useSelector((state: RootState) => state.imageType.type);
  const [ref, { entry }] = useIntersectionObserver();
  const isVisible = entry && entry.isIntersecting;
  const [pokemon, setPokemon] = useState<PokemonDetailType | null>(null);

  function handleClick() {
    navigate(`/pokemon/${props.name}`);
  }

  useEffect(() => {
    if (!isVisible) {
      return;
    }

    (async () => {
      const detail = await fetchPokemonDetail(props.name);
      setPokemon(detail);
    })();
  }, [props.name, isVisible]);

  if (!pokemon) {
    return (
      <Item color={"#fff"} ref={ref}>
        <Header>
          <PokeNameChip name={"포켓몬"} color={"#ffca09"} id={0} />
        </Header>
        <Body>
          <PokeImageSkeleton />
        </Body>
        <Footer>
          <PokeMarkChip />
        </Footer>
      </Item>
    );
  }

  return (
    <Item onClick={handleClick} color={pokemon.color} ref={ref}>
      <Header>
        <PokeNameChip
          name={pokemon.koreanName}
          color={pokemon.color}
          id={pokemon.id}
        />
      </Header>
      <Body>
        <Image src={pokemon.images[imageType]} alt={pokemon.name} />
      </Body>
      <Footer>
        <PokeMarkChip />
      </Footer>
    </Item>
  );
}

const Item = styled.li<{ color: string }>`
  display: flex;
  flex-direction: column;
  padding: 8px;
  width: 250px;
  height: 300px;
  border: 1px solid #c0c0c0;
  box-shadow: 1px 1px 3px 1px #c0c0c0;

  cursor: pointer;
  transition: transform 0.3s ease-in-out;

  &:hover {
    transform: scale(1.1);
  }

  &:active {
    background-color: ${(props) => props.color};
    opacity: 0.8;
    transition: background-color 0s;
  }
`;

const Header = styled.section`
  display: flex;
  margin: 8px 0;
`;

const Body = styled.section`
  display: flex;
  flex: 1;
  justify-content: center;
  align-items: center;
  margin: 8px 0;
`;

const Image = styled.img`
  width: 180px;
  height: 180px;
`;

const Footer = styled.section`
  display: flex;
  margin: 8px 0;
`;