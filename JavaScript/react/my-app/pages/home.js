import Link from "next/link";

function Home() {
  return (
    <ul>
      <li>
        <Link href={"/"}>
          <a>Home</a>
        </Link>
      </li>
      <li>
        <Link href={"/my/account"}>
          <a>My account</a>
        </Link>
      </li>
      <li>
        <Link href={"/my/info"}>
          <a>My Info</a>
        </Link>
      </li>
    </ul>
  );
}

export default Home;
