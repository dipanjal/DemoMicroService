package com.dipanjal.example.microservices.CurrencyExchangeService.service;

import com.dipanjal.example.microservices.CurrencyExchangeService.exception.CurrencyExchangeException;
import com.dipanjal.example.microservices.CurrencyExchangeService.model.CurrencyExchange;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;

@Service("currencyExchangeServiceSoap")
public class CurrencyExchangeServiceSoap implements CurrencyExchangeService {

    @Override
    public CurrencyExchange fetchValue(String from, String to) throws CurrencyExchangeException {
        return new CurrencyExchange(1L, from, to, new BigDecimal(65));
    }
}