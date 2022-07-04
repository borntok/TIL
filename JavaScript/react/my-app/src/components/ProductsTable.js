import React from "react";

export default function ProductsTable(props) {
  const { category, items, inStockOnly } = props;
  const filteredItems = inStockOnly
    ? items.filter((item) => item.stocked)
    : items;

  return (
    <>
      <tr style={{ fontWeight: "bold" }}>
        <td>{category}</td>
      </tr>
      {filteredItems.map((item, idx) => (
        <tr key={idx}>
          <td style={{ color: item.stocked ? "black" : "red" }}>{item.name}</td>
          <td>{item.price}</td>
        </tr>
      ))}
    </>
  );
}
