export const fetchUser = () => {
  return new Promise((resolve) => {
    setTimeout(
      () => resolve({ name: "riri", email: "riri@badgyal.com" }),
      2000
    );
  });
};
