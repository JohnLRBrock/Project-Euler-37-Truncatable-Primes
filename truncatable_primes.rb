# John Brock
# https://projecteuler.net/problem=37
# Truncatable Primes
# 2018-10-22

def sieve_of_eratosthenes(max)
  list = Array.new(max + 1, true)
  list[0] = false
  list[1] = false

  list.each_with_index do |bool, i|
    if bool
      j = 0
      while (i ** 2 + (i * j)) <= max
        list[i ** 2 + (i * j)] = false
        j += 1
      end
    end
  end
  list
end

# calls sieve generator if sieve doesn't currently exist or is too small
def sieve_init(n)
  return sieve_of_eratosthenes(n) unless $sieve
  return sieve_of_eratosthenes(n * 2) if n + 1 < $sieve.length
  $sieve
end

def truncatable_prime?(n)
  $sieve = sieve_init(n)
  prime?(n) &&
  forwards_truncate?(n) &&
  backwards_truncate?(n)
end

def prime?(n)
  $sieve[n]
end

# removes the front digit until there's one digit left and
# checks if the number at each step is prime.
def forwards_truncate(n)
  digit_array = n.digits
  (digit_array.length - 1).times do
    digit_array.pop
    p digit_array
    return false unless prime?(digit_array.join.to_i)
  end
  true
end

# same as above by last digit instead of first
def backwards_truncate(n)
    digit_array = n.digits
  (digit_array.length - 1).times do
    digit_array.shift
    p digit_array
    return false unless prime?(digit_array.join.to_i)
  end
  true
end
