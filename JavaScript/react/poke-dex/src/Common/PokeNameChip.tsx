import styled from "@emotion/styled";

interface PokeNameChipProps {
  name: string;
  color: string;
  id: number;
}

export default function PokeNameChip(props: PokeNameChipProps) {
  function renderNumber(id: number) {
    const disits = 3;
    const numberString = id.toString();

    if (numberString.length >= disits) {
      return numberString;
    }

    let result = "";
    for (let i = 0; i < disits - numberString.length; i++) {
      result += "0";
    }

    return result + numberString;
  }

  return (
    <Chip>
      <NumberChip color={props.color}>
        <Number>{renderNumber(props.id)}</Number>
      </NumberChip>
      <Text>{props.name}</Text>
    </Chip>
  );
}

const Chip = styled.div`
  display: flex;
  align-items: center;
  border: 1px solid #c0c0c0;
  border-radius: 16px;
  font-weight: bold;
  box-shadow: 0.5px 0.5px 0 0 #c0c0c0;
`;

const NumberChip = styled.div<{ color: string }>`
  padding: 4px 6px;
  background-color: ${(props) => props.color};
  border-radius: 16px;
  opacity: 0.8;
`;

const Number = styled.label`
  opacity: 1;
`;

const Text = styled.label`
  margin: 0 8px 0 5px;
`;
