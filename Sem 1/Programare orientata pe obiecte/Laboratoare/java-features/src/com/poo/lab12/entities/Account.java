package com.poo.lab12.entities;

import java.util.Objects;

import com.poo.lab12.exceptions.NotEnoughFundsException;

public class Account implements Comparable<Account>{
    private final int id;
	private double balance;
	private final double maximumAmountToWithdraw;
    
    public Account(int id, double balance, double maximumAmountToWithdraw) {
		this.id = id;
		this.balance = balance;
		this.maximumAmountToWithdraw = maximumAmountToWithdraw;
	}

	public void deposit(final double amount) {
		if (amount < 0) {
			throw new IllegalArgumentException("Cannot deposit a negative amount");
		}
		this.balance += amount;
	}

	public void withdraw(final double amount) throws NotEnoughFundsException {
		if (amount < 0) {
			throw new IllegalArgumentException("Cannot withdraw a negative amount");
		}
		
		if (amount > getMaximumAmountToWithdraw()) {
			throw new NotEnoughFundsException(id, balance, amount, "Requested amount exceeds the maximum amount to withdraw");
		}
		
		this.balance -= amount;
	}

	public int getId() {
		return id;
	}

	public double getBalance() {
		return balance;
	}

	public double getMaximumAmountToWithdraw() {
		return maximumAmountToWithdraw;
	}

	public int decimalValue() {
		return (int)Math.round(balance);
	}

	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (o == null || getClass() != o.getClass()) return false;
		Account that = (Account) o;
		return getId() == that.getId() &&
				Double.compare(that.getBalance(), getBalance()) == 0 &&
				Double.compare(that.getMaximumAmountToWithdraw(), getMaximumAmountToWithdraw()) == 0;
	}

	@Override
	public String toString() {
		return "Account{" +
				"id=" + id +
				", balance=" + balance +
				", maximumAmountToWithdraw=" + maximumAmountToWithdraw +
				"}\n";
	}

	@Override
	public int hashCode() {
		return Objects.hash(getId(), getBalance(), getMaximumAmountToWithdraw());
	}

	@Override
	public int compareTo(Account o) {
		return Double.compare(balance, o.getBalance());
	}
}
