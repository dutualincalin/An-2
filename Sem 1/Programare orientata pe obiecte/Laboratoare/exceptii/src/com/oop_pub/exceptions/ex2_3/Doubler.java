package com.oop_pub.exceptions.ex2_3;

import java.util.Collection;

public class Doubler implements Calculator{
    @Override
    public Double add(Double nr1, Double nr2) {
            if (null == nr1 | null == nr2)
                throw new NullParameterException();

            if (nr1 + nr2 == Double.POSITIVE_INFINITY)
                throw new OverflowException();

            if (nr1 + nr2 == Double.NEGATIVE_INFINITY)
                throw new UnderflowException();

            return nr1 + nr2;
    }

    @Override
    public Double divide(Double nr1, Double nr2) {
        if(null == nr1 | null == nr2)
            throw new NullParameterException();

        if(nr1 + nr2 == Double.POSITIVE_INFINITY)
            throw new OverflowException();

        if(nr1 + nr2 == Double.NEGATIVE_INFINITY)
            throw new UnderflowException();

        return nr1/nr2;
    }

    @Override
    public Double average(Collection<Double> numbers) {
        final double[] sum = {0};
        numbers.forEach(number -> sum[0] = add(sum[0], number));
        return divide(sum[0] , (double) numbers.size());
    }
}
