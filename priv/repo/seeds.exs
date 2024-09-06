alias MagicCommander.Repo
alias MagicCommander.Accounts.Account

admin_params = %{
  email: "admin@admin.com",
  hash_password: "admin123@",
  role: "admin"
}

case Repo.get_by(Account, email: "admin@admin.com") do
  nil ->
    %Account{}
    |> Account.changeset(admin_params)
    |> Repo.insert!()

    IO.puts("Usuário admin criado com sucesso!")

  _ ->
    IO.puts("Usuário admin já existe. Nenhuma ação tomada.")
end
