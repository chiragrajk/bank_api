defmodule BankAPI.Accounts.Supervisor do
  use Supervisor

  alias BankAPI.Accounts

  def start_link() do
    Supervisor.start_link(__MODULE__, nil)
  end

  def start_link(_args) do
    Supervisor.start_link(__MODULE__, nil)
  end

  def init(_arg) do
    children = [
      worker(Accounts.Projectors.AccountOpened, [], id: :account_opened)
    ]

    supervise(children, strategy: :one_for_one)
  end
end
