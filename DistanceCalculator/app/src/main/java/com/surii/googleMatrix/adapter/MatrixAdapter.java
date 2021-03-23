package com.surii.googleMatrix.adapter;

import android.content.Context;
import android.widget.ArrayAdapter;
import android.widget.Filterable;

import com.surii.googleMatrix.model.MatrixApi;

import java.util.ArrayList;

public class MatrixAdapter  extends ArrayAdapter {

        ArrayList<String> results;

        int resource;
        Context context;

        MatrixApi matrixApi=new MatrixApi();

        public MatrixAdapter(Context context,int resId){
            super(context,resId);
            this.context=context;
            this.resource=resId;

        }

        @Override
        public int getCount(){
            return results.size();
        }

        @Override
        public String getItem(int pos){
            return results.get(pos);
        }



    }
