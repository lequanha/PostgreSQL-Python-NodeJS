var promise = require('bluebird');

var options = {
  // Initialization Options
  promiseLib: promise
};

var pgp = require('pg-promise')(options);
var connectionString = 'postgres://artesianproject:artesianproject@artesianproject.c0pbwgrsqsdx.us-east-1.rds.amazonaws.com:5432/artesianproject';
var db = pgp(connectionString);

// add query functions

module.exports = {
  getAllData: getAllData,
  getSingleData: getSingleData,
  createData: createData,
  getAllSensors: getAllSensors,
  getAllClusters: getAllClusters,
  createCluster: createCluster,
  removeCluster: removeCluster,
  createSensor: createSensor,
  removeSensor: removeSensor,
  getClusterID: getClusterID
};

function getAllSensors(req, res, next) {
  db.any('select * from sensors."sensors" LIMIT 1000')
    .then(function (data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Retrieved ALL sensors'
        });
    })
    .catch(function (err) {
      return next(err);
    });
}

function getAllClusters(req, res, next) {
  db.any('select * from sensors."clusters" LIMIT 1000')
    .then(function (data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Retrieved ALL clusters'
        });
    })
    .catch(function (err) {
      return next(err);
    });
}

function getAllData(req, res, next) {
  db.any('select * from sensors."clustereddata" LIMIT 1000')
    .then(function (data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Retrieved ALL data'
        });
    })
    .catch(function (err) {
      return next(err);
    });
}

function getSingleData(req, res, next) {
  var ID = parseInt(req.params.id);
  console.log(ID);

  db.one('select * from sensors."clustereddata" where "id" = $1', ID)
    .then(function (data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Retrieved ONE data'
        });
    })
    .catch(function (err) {
      return next(err);
    });
}

function createData(req, res, next) {
  var data =  parseFloat(req.params.data);
  var clusterid = parseInt(req.params.clusterid);
  var sensorid = parseInt(req.params.sensorid);

  db.none('insert into sensors."clustereddata"("clusterid", "sensorid", "data") ' +
      'values(' + clusterid + ', ' + sensorid + ', ' + data + ')',
    req.body)
    .then(function () {
      res.status(200)
        .json({
          status: 'success',
          message: 'Inserted one data'
        });
    })
    .catch(function (err) {
      return next(err);
    });
}

function getClusterID(req, res, next) {
  var mean =  parseFloat(req.params.mean);
  var deviation = parseFloat(req.params.deviation);

  db.one('select "clusterid" from sensors."clusters" where "mean" = ' + mean + ' and "deviation" = ' + deviation)
    .then(function (data) {
      res.status(200)
        .json({
          status: 'success',
          data: data,
          message: 'Retrieved ONE data'
        });
    })
    .catch(function (err) {
      return next(err);
    });

}

function createCluster(req, res, next) {
  var mean =  parseFloat(req.params.mean);
  var deviation = parseFloat(req.params.deviation);
  db.none('insert into sensors."clusters"("mean", "deviation") ' +
      'values(' + mean + ', ' + deviation + ')',
    req.body)
    .then(function () {
      res.status(200)
        .json({
          status: 'success',
          message: 'Inserted one cluster'
        });
    })
    .catch(function (err) {
      return next(err);
    });
}


function removeCluster(req, res, next) {
  var mean =  parseFloat(req.params.mean);
  var deviation = parseFloat(req.params.deviation);
  db.result('delete from sensors."clusters" where "mean" = ' + mean + ' and "deviation" = ' + deviation)
    .then(function (result) {
      res.status(200)
        .json({
          status: 'success',
          message: `Removed ${result.rowCount} clusters`
        });
    })
    .catch(function (err) {
      return next(err);
    });
}

function createSensor(req, res, next) {
  var name = req.params.name;
  var ID = parseInt(req.params.id);
  db.none('insert into sensors."sensors"("sensorid", "name") ' +
      'values(' + ID + ', \'' + name + '\')',
    req.body)
    .then(function () {
      res.status(200)
        .json({
          status: 'success',
          message: 'Inserted one sensor'
        });
    })
    .catch(function (err) {
      return next(err);
    });
}


function removeSensor(req, res, next) {
  var name = req.params.name;
  db.result('delete from sensors."sensors" where "name" = \'' + name + '\' ')
    .then(function (result) {
      res.status(200)
        .json({
          status: 'success',
          message: `Removed ${result.rowCount} sensors`
        });
    })
    .catch(function (err) {
      return next(err);
    });
}

